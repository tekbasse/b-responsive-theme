set instance_id [ad_conn package_id]
set admin_p [permission::permission_p -object_id $instance_id -privilege "admin"]

set pbody ""
if { !$admin_p } {
    ad_script_abort

}




# list from to using regsub
# switches pattern subspec

# No need for IE versions before 9 per
# http://www.welivesecurity.com/2016/01/12/microsoft-ends-support-for-old-internet-explorer-versions/


# To support IE 9, add these list items to $c(0):
# \[list "" {@doc.type;literal@} {@doc.type;literal@
#    <!--[if gt IE 8]><!--> <html<if @doc.lang@ not nil> lang="@doc.lang;literal@"</if> class="no-js"> <!--<![endif]-->}
# \]
# \[list "" {<if @head@ not nil>}  {<!--[if gt IE 8]> <script src="/resources/b-responsive-theme/respond.min.js"></script> <![endif]-->
#    <if @head@ not nil>}
# \]
#

set fname(0) "blank-master.adp"


set c(0) [list \
              [list "" {</title>} {</title>
                  <meta name="viewport" content="width=device-width, initial-scale=1">
                  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
              }] \
              [list "-all" {<comment>} {<!-- }] \
              [list "-all" {</comment>} { -->}] \
             ]

set fname(1) "blank-master.tcl"

# AG: Markup in TITLE tags do  not render well
set c(1) [list \
              [list "" {(if {!\[info exists doc\(charset\)\]} )} {set doc(title) [ns_striphtml $doc(title)]
\1 }] \
             ]



# just read, and then write to local package dir.

# rdir original directory
set rdir "[acs_root_dir]/www"
# wdir work directory
set wdir "[acs_root_dir]/packages/b-responsive-theme/www"

set i_list [list 0 1]
foreach i $i_list {
    append pbody "\n"

    # filec file contents
    set filec($i) ""
    set rpath [file join $rdir $fname(${i})]
    if [catch {open $rpath r} fileId] {
        append pbody "Unable to read file: '${rpath}'.\n"
    } else {
        while { [eof $fileId] != 1 } {
            gets $fileId line
            append filec(${i}) $line
            append filec(${i}) "\n"
        }
        close $fileId
    }
    set fcontents $filec(${i})
    set c_len [llength $c(${i})]
    set j 0
    set regsub_count 1
    
    while { $j < $c_len } {
        ns_log Notice "b-responsive/www/doc/originals/blank-master-master.tcl i $i j $j"
        set change_list [lindex $c(${i}) $j]
        set switch [lindex $change_list 0]
        set pattern [lindex $change_list 1]
        set subspec [lindex $change_list 2]
        regsub -all -- {[\ ]+} $subspec { } subspec
        if { $switch ne "" } {
            set regsub_count [regsub $switch -- $pattern $fcontents $subspec fcontents ]
        } else {
            set regsub_count [regsub -- $pattern $fcontents $subspec fcontents ]
        }
        append pbody $j ". "
        if { $regsub_count > 0 } {
            append pbody "done."
        } else {
            append pbody "unchanged: regsub "
            append pbody $switch " -- " $pattern " old_line " $subspec " new_line
"
        }
        append pbody "\n
"
        incr j
    }

    set wpath [file join $wdir $fname(${i})]
    if { [file exists $wpath] } {
        set suffix ".bak"
        append suffix "-" [clock format [clock seconds] -format "%Y%m%d%H%M%S"]
        set newname $wpath
        append newname $suffix
        file copy $wpath $newname
        file delete $wpath
    }
    if [catch {open $wpath w} fileId] {
        append pbody "Unable to write file: '${wpath}'.\n"
    } else {
        puts $fileId $fcontents
        close $fileId
    }
   
}

append pbody "Reference url for MASTER tag: /packages/b-responsive-theme/blank-master"
