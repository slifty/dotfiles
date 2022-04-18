echo "Setting up jenv"
for d in /Library/Java/JavaVirtualMachines/*jdk*/ ; do
    jenv add $d/Contents/Home/
done