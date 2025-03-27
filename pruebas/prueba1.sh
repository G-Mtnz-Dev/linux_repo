# **************************************************************************** #
#                                                                              #
#                                                        #  |  #               #
#    File: prueba1.sh                                   #   |   #              #
#                                                      #    |    #             #
#    By: G-Mtnz Dev   <dev.gmartinez@gmail.com>       #     |     #            #
#                                                      #    |    #             #
#    Created: 2025/03/27 13:37:42 by G-Mtnz Dev         #   |   #              #
#    Updated: 2025/03/27 02:11:04 by G-Mtnz Dev          #  |  #               #
#                                                                              #
# **************************************************************************** #

sudo mount -t ntfs UUID=524F567904D39ECB /media/DATOS/

sudo apt update && sudo apt upgrade && sudo snap refresh && sudo apt autoclean && sudo apt clean && sudo apt autoremove

rclone mount gdrive: ~/Drive &
