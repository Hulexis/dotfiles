sudo mkdir /etc/1password
echo vivaldi-bin | sudo tee /etc/1password/custom_allowed_browsers
sudo chown root:root /etc/1password/custom_allowed_browsers
sudo chmod 755 /etc/1password/custom_allowed_browsers
