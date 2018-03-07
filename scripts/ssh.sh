openssl aes-256-cbc -K $encrypted_eaec4b58e59b_key -iv $encrypted_eaec4b58e59b_iv -in ~/.ssh/id_borm_travis.enc -out ~/.ssh/id_borm_travis -d
chmod 0400 ~/.ssh/id_borm_travis
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_borm_travis