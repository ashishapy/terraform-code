# AWS Components to be created:

Default region is 'us-west-2' & custom AMI id is 'ami-3c4dec5c' (Docker 1.12.3 & Docker Compose 1.8.1 installed 
on Ubuntu 16.04 LTS (x64))

- VPC
- Internet Gateway for public subnet
- Public subnet for routing instances
- Private subnet for internal resources
- Routing tables for public and private subnets
- NAT/VPN server to route outbound traffic from your instances in private network and provide your workstation secure 
    access to network resources.
- Application servers running nginx docker containers in a private subnet
- Load balancers in the public subnet to manage and route web traffic to app servers

# Create SSH Key Pair:

`$ ssh-keygen -t rsa -C "insecure-deployer" -P '' -f ssh/insecure-deployer`

# Configure OpenVPN Server and Generate Client Configuration

- Initialize PKI 
    ```
        $ chmod +x bin/ovpn-init 
        $ bin/ovpn-init
    ```

    The above command will prompt you for a passphrase for the root certificate. Choose a strong passphrase and store it 
    some where safe. This passphrase is required every time you generate a new client configuration.

- Start the VPN server

    ```
        $ chmod +x bin/ovpn-start
        $ bin/ovpn-start
    ```

- Generate client certificate

    ```
        $ chmod +x bin/ovpn-new-client
        # generate a configuration for your user
        $ bin/ovpn-new-client $USER
    ```

- Download OpenVPN client configuration

    ```
        $ chmod +x bin/ovpn-client-config
        $ bin/ovpn-client-config $USER
    ```

    The above command creates a $USER-airpair-example.ovpn client configuration file in the current directory. 
    Double-click on the file to import the configuration to your VPN client. You can also connect using an iPhone/Android 
    device. Check out OpenVPN Connect for iPhone and OpenVPN Connect on Play Store.

# Test your Private Connection:

After successfully connecting using the VPN client, connect to one of the app servers using a private IP address.

`$ open "http://$(terraform output kube.1.ip)"`

`$ ssh -t -i ssh/insecure-deployer "ubuntu@$(terraform output kube.1.ip)"`
