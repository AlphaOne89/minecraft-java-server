# raspberry.pi.minecraft.server

A sh based script that installs the Java library, creates a screen window, and starts a Minecraft server.

### INSTALL
```sh
git clone --depth 1 https://github.com/xxalfa/raspberry.pi.minecraft minecraft

cd minecraft && sh screen.minecraft.sh
```
### UPDATE
If the update argument is passed, a request is sent and a check is made as to whether there is a new server version in order to replace it if necessary.
```sh
sh screen.minecraft.sh update
```
