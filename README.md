# TeXStudioSetup
Downloads Necessary Files for setting up TeXStudio

## Installing TeXStudio and LaTeX

The following command will download and install both TeXStudio and LaTeX if you
are running Debian or Ubuntu. Be warned, texlive-full is really large. Afterwards,
`autoremove` is run, as `texlive-full` usually has unneeded packages.

```bash
sudo apt install texstudio texlive-full
sudo apt autoremove
```

## TeXStudio Dictionaries

The following code downloads en_US dictionaries. These can be added to TeXStudio
using `Options`->`Configure TeXStudio`->`Language Checking`->`Spell Check`.

```bash
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
```

## TeXStudio Language Tool
This Language Tool supports much better Grammar checking. After download the
`.jar` file using the commands below, add it to TeXStudio
using `Options`->`Configure TeXStudio`->`Language Checking`->`LanguageTool`.

```bash
mkdir tmp/
wget -O tmp/LanguageTool-3.5.zip https://languagetool.org/download/LanguageTool-3.5.zip
unzip tmp/LanguageTool-3.5.zip 
rm -rf tmp/
```

## Installing IEEE Bibliography Files

```bash
mkdir tmp/
cd tmp/
wget http://www.ieee.org/documents/IEEEtranBST.zip
unzip IEEEtranBST.zip
sudo mkdir /etc/texmf/bibtex/
sudo mkdir /etc/texmf/bibtex/bst/
sudo mv *.bst /etc/texmf/bibtex/bst/
cd ../
rm -rf tmp/
```

Then they can be used in LaTeX by adding this to your code:
```latex
\bibliographystyle{IEEEtran}
```


