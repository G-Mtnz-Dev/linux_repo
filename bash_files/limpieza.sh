# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    limpieza.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: G. Mtnz <dev.gmartinez@gmail.com>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/18 13:37:42 by G.Mtnz            #+#    #+#              #
#    Updated: 2025/03/26 15:50:59 by G. Mtnz          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#!/bin/bash

<< 'MULTILINE-COMMENT'
============= LIMPIEZA x PARTES ====================

sudo apt update
sudo apt upgrade
sudo snap refresh
sudo apt autoclean
sudo apt clean
sudo apt autoremove

====================================================
MULTILINE-COMMENT

sudo apt update && sudo apt upgrade && sudo snap refresh && sudo apt autoclean && sudo apt clean && sudo apt autoremove 

exit