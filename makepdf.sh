pandoc README.md -o README.tex
pandoc --template=template.tex README.tex -o README.pdf
rm README.tex

