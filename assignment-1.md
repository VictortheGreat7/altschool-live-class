# Assignment

**My login name:** `vagrant`  
**My Home directory:** `/home/vagrant`

### Directory Structure (Subdirectories needed)

- `code`
- `tests`
- `personal`
- `misc`

![Screenshot 1](./screenshots/directory-structure.png)

## Tasks

### a. Navigate to the 'tests' directory using its absolute pathname.

```bash
cd /home/vagrant/tests
```
![Screenshot 2](./screenshots/absolute-pathname.png)

### b. Navigate to the 'tests' directory using its relative pathname.

```bash
cd tests
```
![Screenshot 3](./screenshots/relative-pathname.png)

### c. Use the echo command to create a file named 'fileA' with the text content 'Hello A' in the 'misc' directory.

```bash
echo 'Hello A' > /home/vagrant/misc/fileA
```
![Screenshot 4](./screenshots/echo-create-file.png)

### d. Create an empty file named 'fileB' in the 'misc' directory and then populate it with dummy content.

```bash
touch /home/vagrant/misc/fileB && echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dapibus purus et augue fringilla, vel sollicitudin neque consequat. Nam vel justo non leo laoreet convallis." > /home/vagrant/misc/fileB
```
![Screenshot 5](./screenshots/dummy-content.png)

### e. Copy the contents of 'fileA' into a new file named 'fileC'.

```bash
cp /home/vagrant/misc/fileA /home/vagrant/misc/fileC
```
![Screenshot 6](./screenshots/copy-content.png)

### f. Move the contents of 'fileB' into a new file named 'fileD'.

```bash
cp /home/vagrant/misc/fileB /home/vagrant/misc/fileD && echo -n > /home/vagrant/misc/fileB
```
![Screenshot 7](./screenshots/move-content.png)

### g. Create a tar archive called 'misc.tar' for the contents of the 'misc' directory.

```bash
tar -cf /home/vagrant/misc/misc.tar -C /home/vagrant/misc .
```
![Screenshot 8](./screenshots/create-archive.png)

### h. Compress the tar archive to create a 'misc.tar.gz' file.

```bash
gzip /home/vagrant/misc/misc.tar
```
![Screenshot 9](./screenshots/compress-archive.png)

### i. Create a new user and enforce a password change upon their first login.

```bash
sudo useradd -m -s /bin/bash newuser && sudo passwd newuser && sudo passwd -e newuser
```
![Screenshot 10](./screenshots/add-user-password.png)

### j. Lock a user's password to prevent login access.

```bash
sudo passwd -l username
```
![Screenshot 11](./screenshots/lock-access.png)

### k. Create a user with no login shell access.

```bash
sudo useradd -m -s /bin/false newuser
```
![Screenshot 12](./screenshots/no-login-access.png)

### l. Disable password-based authentication for SSH.

```bash
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && sudo systemctl restart sshd
```

### m. Disable root login for SSH.

```bash
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && sudo systemctl restart sshd
```
