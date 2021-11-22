function program-gooey {
    # $p= Get-Process "Crank Storyboard"
    # $initial_legth = $p.Length
    # $l
    # & 'C:/Program Files/Crank_Software/Storyboard_Designer/Crank Storyboard.exe' -application com.crank.gdt.ui.configexport model=c:/traeger/gooey_storyboard/gooey_v2.gde configuration=gooey_v2.gde-Exporter
    # $p= Get-Process "Crank Storyboard"
    # $l = $p.Length
    # while($l -gt $initial_legth) {
    #     $p= Get-Process "Crank Storyboard"
    #     $l = $p.Length
    # }

    # "all done"

    Copy-Item sbengine_model.h c:/traeger/gooey/gooey/source/storyboard/
    Push-Location c:/traeger/gooey/gooey
    make flash
    Pop-Location
}

function program-kirby {
    make
    smk write --internal --address 0xc000 --path .\build\debug_dev\Kirby.bin.pad.hash
}

New-Alias -Name pg -Value program-gooey
New-Alias -Name pk -Value program-kirby

function left ($num){
    if($num){
        for($i=0;$i -lt $num;$i++){
            iogen application - Sim_EncoderRotCCWSlow
        }
    } 
    else {
        iogen application - Sim_EncoderRotCCWSlow
    }
}
function right ($num){
    if($num){
        for($i=0;$i -lt $num;$i++){
            iogen application - Sim_EncoderRotCWSlow
        }
    } 
    else {
        iogen application - Sim_EncoderRotCWSlow
    }
}
function press {
    iogen application - Sim_EncoderButton_Press
}