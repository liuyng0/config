#!/bin/bash
. ~/.bash_environment_setup
external_keyboard_exist=`system_profiler SPUSBDataType | grep "Rapoo Gaming Keyboard"`
external_keyboard_exist2=`system_profiler SPUSBDataType | grep "CHERRY"`
external_keyboard_exist3=`system_profiler SPUSBDataType | grep "Holtek Semiconductor"`

if [ -z "$external_keyboard_exist" ] && [ -z "$external_keyboard_exist2" ] && [ -z "$external_keyboard_exist3" ]; then
    echo "switch to use configuration for internal keyboard"
    cp $VIF_CONFIG/karabiner-internal.json ~/.karabiner.d/configuration/karabiner.json
else
    echo "switch to use configuration for external keyboard"
    cp $VIF_CONFIG/karabiner-external.json ~/.karabiner.d/configuration/karabiner.json
fi
