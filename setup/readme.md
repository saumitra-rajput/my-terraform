## In this Module we are setting up terraform

I am using my ubuntu-server-linux machine for this tutorial.
Firstly Login into the ubuntu server using ssh-private-key using 

Hashicorp offical Click on [Link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to read more.

```
ssh -i %USERPROFILE%\.ssh\azure_cmd_key jarvis@192.1258.1.105


```
Enter your password for private key if there is any.

- Get your machine with the latest updates

```
sudo apt-get updates
```
![alt text](image.png)

Now follow the offical Documentation from HashiCorp to install terraform.

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
![alt text](image-1.png)

```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

```
![alt text](image-2.png)

```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

```
![alt text](image-3.png)

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

![alt text](image-4.png)

```
sudo apt update
```
![alt text](image-5.png)

```
sudo apt-get install terraform
```
![alt text](image-6.png)

```
terraform --version
```
![alt text](image-7.png)


