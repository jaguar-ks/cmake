#!/bin/bash

#COLORS
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
PURPEL="\033[0;35m"
YELLOW="\033[1;33m"
RESET="\033[0m"

printf "$GREEN
         ██████╗███╗   ███╗ █████╗ ██╗  ██╗███████╗
        ██╔════╝████╗ ████║██╔══██╗██║ ██╔╝██╔════╝
        ██║     ██╔████╔██║███████║█████╔╝ █████╗  
        ██║     ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝  
        ╚██████╗██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗
         ╚═════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝$RESET
                Made by:$RED 0xj4gu4r$RESET\n"

touch Makefile

printf "\r$BLUE[SOURCE CODE]:$RESET Specifiy the root directory of your source code: "

read SDIR

if [[ -d "$SDIR" ]]; then
    printf "\r$BLUE[EXTENTION]:$RESET Specifiy the source code extantion: "
    read EXT
    while [ -z "$EXT" ]; do printf "\r$RED""ERROR:$RESET You entred an empty string try again: "; read EXT; done
    echo "SRC = " $(find $SDIR -type f -name "*.$EXT") > Makefile
else
    printf "\r$RED""ERROR: $RESET""There is no directory by the following name $BLUE<$SDIR>$RESET\n"
    rm -f Makefile
    exit 1
fi

echo >> Makefile

echo "OBJ_DIR = obj" >> Makefile

echo >> Makefile

echo "OBJ = "'$(patsubst %, $(OBJ_DIR)/%, $(SRC:.'"$EXT"'=.o))' >> Makefile

echo >> Makefile

printf "\r$BLUE[INCLUDES]:$RESET Specifiy the root directory of your librareis: "

read LDIR

if [[ -d "$LDIR" ]]; then
    echo "INC_DIR = $LDIR" >> Makefile
else
    printf "\r$RED""ERROR: $RESET""There is no directory by the following name$BLUE <$LDIR> $RESET\n"
    rm -f Makefile
    exit 1
fi

echo >> Makefile

echo "FLGS = -Wall -Wextra -Werror -std=c++98" >> Makefile

echo >> Makefile

printf "\r$BLUE[EXECUTABLE NAME]:$RESET Entre the program name: "

read PR_N

while [[ -z "$PR_N" ]]; do
    printf "\r$RED""ERROR:$RESET You entred an empty string try again.\n"
    read PR_N
done

echo "NAME = $PR_N" >> Makefile

echo >> Makefile

printf "\r$BLUE[COMPLIER]:$RESET Specify the Compiler: "

read CMPL

while [ -z "$CMPL" ]; do printf "\r$RED""ERROR:$RESET You entred an empty string try again: "; read CMPL; done

echo "all : "'$(NAME)' >> Makefile

echo >> Makefile

echo '$(NAME)'" : "'$(OBJ)' >> Makefile
echo '  '"$CMPL"' $(FLGS) $^ -o $@' >> Makefile

echo >> Makefile

echo '%.o : %.'"$EXT"' $(INC_DIR)' >> Makefile
echo '  mkdir -p $(OBJ_DIR)' >> Makefile
echo '  '"$CMPL"' $(FLGS) -I$(INC_DIR) $< -o $@' >> Makefile

echo >> Makefile

echo "clean :" >> Makefile
echo '  rm -rf $(OBJ_DIR)' >> Makefile

echo >> Makefile

echo "fclean : clean" >> Makefile
echo '  rm -rf $(NAME)' >> Makefile

echo >> Makefile

echo 're  : clean fclean all' >> Makefile

echo >> Makefile

echo '.PHONY : all clean fclean re' >> Makefile

echo >> Makefile

echo '.SILENT : $(NAME) $(OBJ) clean fclean re all' >> Makefile
