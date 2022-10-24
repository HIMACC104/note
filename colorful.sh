#!/bin/bash

function colorful()
{
    local color_reset='\e[0m'
    local color_red='\e[0;31m';
    local color_green='\e[1;32m';
    local color_yellow='\e[1;33m';
    local color_blue='\e[1;34m';
    local color_purple='\e[0;35m]'
    local color_brown='\e[0;33m]'

    red_text="${color_red}I'm red.${color_reset}"
    green_text="${color_green}I'm green.${color_reset}"
    yellow_text="${color_yellow}I'm yellow.${color_reset}"
    blue_text="${color_blue}I'm blue.${color_reset}"
    purple_text="${color_purple}I'm purple.${color_reset}"
    brown_text="${color_brown}I'm brown.${color_reset}"

    echo -e "$red_text"
    echo -e "$green_text"
    echo -e "$yellow_text"
    echo -e "$blue_text"
    echo -e "$purple_text"
    echo -e "$brown_text"
}

colorful
