#!/bin/bash

# installs TeXStudio and TeXLive full
# warning, texlive-full is huge so this might take a while
sudo apt-get install texstudio texlive-full
sudo apt-get autoremove #texlive-full contains some useless stuff

# downloads English dictionaries for TeXStudio
# can be added to TeXStudio using
#     `Options`->`Configure TeXStudio`->`Language Checking`->`Spell Check`
mkdir dictionaries/
cd dictionaries/
mkdir tmp/
cd tmp/
wget https://extensions.libreoffice.org/extensions/english-dictionaries/2016.09.01/@@download/file/dict-en.oxt 
unzip dict-en.oxt
mv en_US.* ../
cd ../
rm -rf tmp/
cd ../

# downloads Grammar Checker for TeXStudio
# add it to TeXStudio by going to:
#     `Options`->`Configure TeXStudio`->`Language Checking`->`LanguageTool`.
mkdir tmp/
wget -O tmp/LanguageTool-3.5.zip https://languagetool.org/download/LanguageTool-3.5.zip
unzip tmp/LanguageTool-3.5.zip 
rm -rf tmp/

# installs IEEE bibliograpgy style for BibTeX
# Can be used by placing `\bibliographystyle{IEEEtran}` into LaTeX file
mkdir tmp/
cd tmp/
wget http://www.ieee.org/documents/IEEEtranBST.zip
unzip IEEEtranBST.zip
sudo mkdir /etc/texmf/bibtex/
sudo mkdir /etc/texmf/bibtex/bst/
sudo mv *.bst /etc/texmf/bibtex/bst/
cd ../
rm -rf tmp/
