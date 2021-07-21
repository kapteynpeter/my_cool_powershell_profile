function program-gooey {
    $p= Get-Process "Crank Storyboard"
    $initial_legth = $p.Length
    $l
    & 'C:/Program Files/Crank_Software/Storyboard_Designer/Crank Storyboard.exe' -application com.crank.gdt.ui.configexport model=c:/traeger/gooey_storyboard/gooey_v2.gde configuration=gooey_v2.gde-Exporter
    $p= Get-Process "Crank Storyboard"
    $l = $p.Length
    while($l -gt $initial_legth) {
        $p= Get-Process "Crank Storyboard"
        $l = $p.Length
    }

    "all done"

    Copy-Item sbengine_model.h c:/traeger/gooey-test/gooey/gooey/source/storyboard/
    Push-Location c:/traeger/gooey-test/gooey/gooey
    make flash
    Pop-Location
}