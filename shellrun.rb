
folder = "d:\rubies\EIIS_SOAP"
<<~`SHELL`
    git status >> log.txt
    cd #{folder}
    echo "==================================================="
    git status
    dir
SHELL