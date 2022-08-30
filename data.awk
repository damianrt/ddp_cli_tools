#!/usr/bin/awk -f

BEGIN {
    if ( sep ) {
        column_delimiter = sep
    } else {
        column_delimiter = ","
    }
    row_delimiter = "\n"
    header_flag = 0
    obs_status_flag = 0

    # reference info from statistical standards: https://sdmx.org/?page_id=3215
    obs_status_label["A"] = "Normal"
    obs_status_label["B"] = "Break"
    obs_status_label["E"] = "Estimated value"
    obs_status_label["F"] = "Forecast value"
    obs_status_label["I"] = "Imputed value (CCSA definition)"
    obs_status_label["M"] = "Missing value"
    obs_status_label["P"] = "Provisional value"
    obs_status_label["ND"] = "No Data"  # FRB Only
 
} 

/<kf:Series/ {

    # Read key/value pairs (metadata)
    # Get series name
    for ( i = 1; i < NF; i++ ) {
        if ( $i ~ /SERIES_NAME/ ) {
            key = tolower($i)
            sub(/=.*/, "", key)
            value = $i
            gsub(/.*=|"/, "", value)
            obs[key] = value
        } else {
            continue
        }
    }
    
}

/<frb:Obs/ {

    for ( i = 1; i <= NF; i++ ) {
        if ( $i ~ /=/ ) {
            key = tolower($i)
            value = $i
            sub(/=.*/, "", key)
            sub(/.*="/, "", value)
            sub(/".*/, "", value)
            obs[key] = value
        }
    }
    
    # Recode missing values (No Data)
    if ( obs["obs_status"] == "ND" ) {
        obs["obs_value"] = ""
    } 

    # Include labels for Obs status
    if ( obs_status_flag ) {
        if ( obs["obs_status"] in obs_status_label ) {
            obs["obs_status_label"] = obs_status_label[ obs["obs_status"] ] 
        } else {
            obs["obs_status_label"] = ""
        }
    }    

    # Write header
    if ( !header_flag ) {

        for ( key in obs ) {
            last_key = key
        }

        ORS = column_delimiter
        for ( key in obs ) {
            if ( key == last_key ) {
                ORS = ""
            }
            print key
        }
        print row_delimiter

        header_flag = 1
    } 
    
    # Write data
    ORS = column_delimiter
    for ( key in obs ) {
        if ( key == last_key ) {
            ORS = ""
        }
        print obs[key]
    }
    print row_delimiter
    
}
