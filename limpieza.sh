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