#!/usr/bin/awk -f

BEGIN {
    if ( sep ) {
        column_delimiter = sep
    } else {
        column_delimiter = ","
    }
    row_delimiter = "\n"
    header_flag = 0
    tif_flag = 1

    # tif labels for freq codes 
    freq2tif[  "8"] = "daily"        # Daily
    freq2tif[  "9"] = "business"     # Business daily (m-f)
    freq2tif[ "17"] = "wmonday"      # Weekly Monday
    freq2tif[ "19"] = "wwednesday"   # Weekly Wednesday
    freq2tif[ "20"] = "wthursday"    # Weekly Thursday
    freq2tif[ "21"] = "wfriday"      # Weekly Friday
    freq2tif[ "67"] = "bw1wednesday" # Biweekly (every other) Wednesday
    freq2tif["129"] = "monthly" 
    freq2tif["162"] = "quarterly" 
    freq2tif["203"] = "annual"

} 

/<kf:Series/ {

    # Read series attributes 
    for ( i = 1; i < NF; i++ ) {
        if ( $i ~ /=/ ) {
            key = tolower($i)
            value = $i
            sub(/=.*/, "", key)
            gsub(/.*=|"/, "", value)
            metadata[key] = value
        }
    }

    # Translate numeric freq code to R/tis tif label
    if ( tif_flag ) {
        if ( metadata["freq"] in freq2tif ) {
            metadata["tif"] = freq2tif[ metadata["freq"] ]
        } else {
            metadata["tif"] = ""
        }
    }

    # Write header
    if ( !header_flag ) {

        for ( key in metadata ) {
            last_key = key
        }

        ORS = column_delimiter
        for ( key in metadata ) {
            if ( key == last_key ) {
                ORS = ""
            }
            print key
        }
        print row_delimiter

        header_flag = 1
    } 
    
    # Write values
    ORS = column_delimiter
    for ( key in metadata ) {
        if ( key == last_key ) {
            ORS = ""
        }
        print metadata[key]
    }
    print row_delimiter
    
}
