# UsefulSetupFiles
A collection of Useful Files to set things up

## OpenAI Gym Install Script

The University computers do not give students super user access, and lack many
dependencies to install [OpenAI Gym](https://gym.openai.com/).
The `installOpenAIGym.sh` script automatically downloads, builds, and installs
`pip`, `cmake`, and OpenAI Gym without `sudo` access.

## TeXStudio Setup Script

The `TeXStudioSetup.sh` script installs TeX and TeXStudio, and then downloads 
English dictionaries, a Grammar checker, and the IEEE bibliography styles. 

The dictionaries and Grammar checker have to be setup in TeXStudio manually, by
going to `Options`->`Configure TeXStudio`->`Language Checking`. 

This script requires `sudo` access for `apt-get` and for installing the bibliography
styles. 
