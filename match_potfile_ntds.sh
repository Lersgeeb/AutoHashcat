#/bin/bash
#a little script to join hashcat's cracked passwords and the original ntds file
#specify the ntds file and the pot file

if [ -z "$2" ]; then
        echo "uso: $0 <ntds file> <pot file>"
        exit 0

else

        compromised_users=$(cut -f1 -d":" $2 | xargs -I % bash -c "grep % $1")
        for compromised_user in $compromised_users; do
                user_hash=$(echo $compromised_user | cut -f4 -d":")
                password=$(grep $user_hash $2)
                echo $compromised_user:$password
done

fi
