#
# Cookbook Name:: audit-demo
# Recipe:: ubuntu-audit-apache
#
# Copyright (c) 2015 Ricardo Lupo, All Rights Reserved.

control_group 'Validate apache configuration' do
  control 'Ensure directory listing is not allowed' do
    it 'does not allow directory listing' do
      expect(file('/etc/apache2/apache2.conf').content).to_not match /Options Indexes/
    end
  end
end
