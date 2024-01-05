#! /bin/bash

menu(){

echo "============================= Welcome to Ncmpcpp Installer ======================="
echo "=================================================================================="
echo "=================================== Version 0.0.1 ================================"
echo "Menu : "
echo ""
echo "1.Complete Install"
echo "2.Remove "
echo "9.Quit"
echo ""
echo "============================= Created By Drogan120 =============================="
echo "================================ Version 0.0.1 =================================="
read -p "what will we do ? [1,2,3] : " ans;

	case $ans in
	1)
		sleep 2
		echo "Welcome to Ncmpcpp Installer"
		echo "We will instal and configure Ncmcpp And Mpd"
		sudo pacman -S mpd mpc ncmpcpp
		configure
		;;
	2)
		sleep 2
		echo "We will remove Ncmpcpp and Mpd"
		sudo pacman -Rc mpd mpc ncmpcpp		
		menu
		;;
	9)
		echo "Closing Program ...."
		sleep 2
		exit
		;;
	*)
		echo "Invalid Options" 
		menu
		;;
	esac
}
configure(){

	echo "Wait We Will Configure Your  Mpd ......"
	sleep 2
	mkdir ~/.mpd
	cd ~/.mpd
	pwd
	touch mpd.log mpd.pid mpd.db mpdstate socket
	echo "1.Alsa"
	echo "2.Pulse"
	read -p "Choose ? [1,2] : " audio;

	case $audio in

	1)
		cat > mpd.conf << "EOF"

		 port "6600"
 		 bind_to_address "127.0.0.1"
 		 #bind_to_address "~/.mpd/socket"
 		 music_directory "~/Music/"
 		 playlist_directory "~/Music"
 		 db_file      "~/.mpd/mpd.db"
 		 log_file      "~/.mpd/mpd.log"
 		 pid_file      "~/.mpd.pid"
 		 state_file     "~/.mpd/mpdstate"
 		 audio_output {

    			 type  "alsa"
     			 name  "alsa"
		}

		audio_output {
    			 type                    "fifo"
    			 name                    "my_fifo"
    			 path                    "/tmp/mpd.fifo"
    			 format                  "44100:16:2"
		}

EOF
amu
;;

      2)
                cat > mpd.conf << "EOF"

                 port "6600"
                 bind_to_address "127.0.0.1"
                 #bind_to_address "~/.mpd/socket"
                 music_directory "~/Music/"
                 playlist_directory "~/Music"
                 db_file      "~/.mpd/mpd.db"
                 log_file      "~/.mpd/mpd.log"
                 pid_file      "~/.mpd/mpd.pid"
                 state_file     "~/.mpd/mpdstate"
                 audio_output {

                         type  "pulse"
                         name  "pulse audio"
                }

                audio_output {
                         type                    "fifo"
                         name                    "my_fifo"
                         path                    "/tmp/mpd.fifo"
                         format                  "44100:16:2"
                }

EOF
amu
;;

	*)
	echo "Invalid Options"
	configure
	;;
esac

}
amu(){

echo "Starting Mpd ..."
sleep 2
service mpd stop
service mpd start
echo "Starting Ncmpcpp ..."
sleep 2
ncmpcpp

}
menu
