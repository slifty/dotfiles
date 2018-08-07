echo "SeTtInG uP jEnV"
for d in /Library/Java/JavaVirtualMachines/jdk*/ ; do
    jenv add $d/Contents/Home/
done

jenv add 