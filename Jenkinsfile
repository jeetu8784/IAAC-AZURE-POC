node {

    stage ('checkout') {

        echo "- - - - Checkout Code - - - -"
	checkout scm
    }

    stage ('setupenv') {
    	echo " - - - - Setting up environment now - - - - "
	}

    stage ('TerraformActivity') {
    
    echo " - - - - Ready to execute Terraform now - - - - "
    sh '''
   echo "started" 
    {
    read
    while read -r line
    do
    	platform=$(echo "$line" |awk -F "," '{ print $1 }')
	
    done
    } < config.csv
    echo " - - - - - - C O M P L E T E D - - - - - - - "
    
    '''
    }
}
