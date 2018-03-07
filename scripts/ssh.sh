openssl aes-256-cbc -K $encrypted_d01ef4b1b1ec_key -iv $encrypted_d01ef4b1b1ec_iv -in .ssh/id_borm_travis.enc -out .ssh/id_borm_travis -d
chmod 0400 .ssh/id_borm_travis
eval $(ssh-agent -s)
ssh-add .ssh/id_borm_travis