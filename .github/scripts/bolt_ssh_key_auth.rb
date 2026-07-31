#!/usr/bin/env ruby
# frozen_string_literal: true

# Force the litmus generated bolt inventory to use SSH key based auth.
#
# This is due to inconsistent password auth failures with certain
# litmus images, particularly on RH9 family.

require 'yaml'
require 'open3'
require 'fileutils'

INVENTORY_PATH = 'spec/fixtures/litmus_inventory.yaml'
KEY_PATH = File.expand_path('litmus_id_ed25519')

def run!(*cmd)
  stdout, stderr, status = Open3.capture3(*cmd)
  raise "Command failed: #{cmd.join(' ')}\n#{stderr}" unless status.success?

  stdout
end

FileUtils.rm_f(KEY_PATH)
FileUtils.rm_f("#{KEY_PATH}.pub")
run!('ssh-keygen', '-t', 'ed25519', '-f', KEY_PATH, '-N', '')
public_key = File.read("#{KEY_PATH}.pub")

container_ids = run!('docker', 'ps', '-q').split("\n")
container_ids.each do |cid|
  image = run!('docker', 'inspect', '--format', '{{.Config.Image}}', cid).strip
  puts "Installing SSH key for root on #{cid} (#{image})"

  run!('docker', 'exec', cid, 'bash', '-c', 'mkdir -p /root/.ssh && chmod 700 /root/.ssh')

  _, stderr_output, status = Open3.capture3(
    'docker', 'exec', '-i', cid, 'bash', '-c', 'cat >> /root/.ssh/authorized_keys',
    stdin_data: public_key
  )
  raise "Failed to install key on #{cid}: #{stderr_output}" unless status.success?

  run!('docker', 'exec', cid, 'bash', '-c', 'chmod 600 /root/.ssh/authorized_keys')

  run!(
    'docker', 'exec', cid, 'bash', '-c',
    "sed -i '/^account/d' /etc/pam.d/sshd; echo 'account required pam_permit.so' >> /etc/pam.d/sshd"
  )
end

inventory = YAML.load_file(INVENTORY_PATH)
inventory['groups'].each do |group|
  group['targets'].each do |target|
    ssh = target['config']['ssh']
    ssh.delete('password')
    ssh['private-key'] = KEY_PATH
  end
end
File.write(INVENTORY_PATH, inventory.to_yaml)

puts "Updated #{INVENTORY_PATH}:"
puts File.read(INVENTORY_PATH)
