# repairPhotosLibrary
Fix user permissions for my private photoslibrary

I have multiple macs on which I acces the drive on which my photo library houses. For some reason the permissions are broken from time to time. This little `bash` script fixes the permissions.

What is does:
1. checks if the library is in place
2. `login` as a user with sufficient admin rights
3. changes permissions so the non-admin user can acces the files
