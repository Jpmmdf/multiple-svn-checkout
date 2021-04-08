#!/bin/bash

baixar_fonte(){
  echo $1
  svn checkout  "$2/$1/trunk" --username $3 --password $4 
}

cria_pasta(){
  if [[ -d "$1" ]]
  then
	echo "$1 pasta ja existe"
  else
	mkdir $1
  fi
}

array=( $@ )
len=${#array[@]}
echo "All Args $@ "

if [ len != 4 ]; then
	filename=${array[0]}
	pathFonte="fontes"
	echo $filename
	if [[ -d "$pathFonte" ]]
  	  then
		echo "$pathFonte ja existe"
	  else
		mkdir $pathFonte
	  fi
	cd $pathFonte
	while IFS= read -r line
	do
	  #toLowerCase
	  toLowerCase="${line,,}"
	  #removendo .ear
	  aplicacao=${toLowerCase//.ear/""}
	  aplicacao=${aplicacao//-/_}
      cria_pasta  $aplicacao
	  echo $aplicacao
	  cd $aplicacao
	  baixar_fonte $aplicacao ${array[1]} ${array[2]} ${array[3]} &
	  #volta para o root
	  cd ..
	done < "$filename"
else
    echo "Esta faltando algum argumento 1 - path do arquivo com as aplicacoes\n 2 - Base uri do SVN 3 - Usuario do SVN\n 4- Senha do SVN\n"
fi