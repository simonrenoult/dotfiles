alias notes=note
function note {
    PATH_TO_NOTES="$HOME/.notes.md"
    NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    args="${@:1}"
    note_content=$args

	if [ $# -eq 0 ]
	  then
	  	subl $HOME/.notes.md
	fi


    echo "Note ajoutée dans ${PATH_TO_NOTES}"

    echo "# $NOW\n\n$note_content\n\n\n$(cat $PATH_TO_NOTES)" > $PATH_TO_NOTES
}
