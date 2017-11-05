if [ "$1" != "" ]; then
	project_template=$1
else
	project_template=project
fi

project=$project_template
counter=0

while [ -d $project  ]; do            
	let counter=counter+1
	project=$project_template$counter 
done

#if [ -d "$PROJECT" ]; then
  # Control will enter here if $DIRECTORY exists.
#	PROJECT=$PROJECT$COUNTER
#fi

mkdir $project
