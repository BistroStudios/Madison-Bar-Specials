package aexp.explist;

import android.app.ExpandableListActivity;
import android.os.Bundle;
import android.widget.SimpleExpandableListAdapter;
import android.widget.TextView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class ExpList extends ExpandableListActivity
{
    static final String colors[] = {
	  "Jordan's Big 10 Pub",
	  "Lucky's",
	  "Wando's",
	  "Brothers"
	};

	static final String shades[][] = {
// Jordan's Specials
	  {
		"2-for-1 Rails","",
		"PBR","$1"
	  },
// Lucky's Specials
	  {
		"dodgerblue 2","#1C86EE",
		"steelblue 2","#5CACEE",
		"powderblue","#B0E0E6"
	  },
// Wando's Specials
	  {
		"yellow 1","#FFFF00",
		"gold 1","#FFD700",
		"darkgoldenrod 1","	#FFB90F"
	  },
// Brothers' Specials
	  {
		"indianred 1","#FF6A6A",
		"firebrick 1","#FF3030",
		"maroon","#800000"
	  }
    };

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle icicle)
    {
        super.onCreate(icicle);
        setContentView(R.layout.main);
        
        // Set up date
        TextView currentDateText =
        	(TextView)  this.findViewById(R.id.specialsFor);
        Date now = new Date();
        SimpleDateFormat format = new SimpleDateFormat("E, MMMM d");
		currentDateText.setText("Current Specials for: " + format.format(now));
        
        // Set up bar list
		SimpleExpandableListAdapter expListAdapter =
			new SimpleExpandableListAdapter(
				this,
				createGroupList(),	// groupData describes the first-level entries
				R.layout.group_row,	// Layout for the first-level entries
				new String[] { "colorName" },	// Key in the groupData maps to display
				new int[] { R.id.groupname },		// Data under "colorName" key goes into this TextView
				createChildList(),	// childData describes second-level entries
				R.layout.child_row,	// Layout for second-level entries
				new String[] { "shadeName", "rgb" },	// Keys in childData maps to display
				new int[] { R.id.childname, R.id.rgb }	// Data under the keys above go into these TextViews
			);
		setListAdapter( expListAdapter );
    }

/**
  * Creates the group list out of the colors[] array according to
  * the structure required by SimpleExpandableListAdapter. The resulting
  * List contains Maps. Each Map contains one entry with key "colorName" and
  * value of an entry in the colors[] array.
  */
	private List createGroupList() {
	  ArrayList result = new ArrayList();
	  for( int i = 0 ; i < colors.length ; ++i ) {
		HashMap m = new HashMap();
	    m.put( "colorName",colors[i] );
		result.add( m );
	  }
	  return (List)result;
    }

/**
  * Creates the child list out of the shades[] array according to the
  * structure required by SimpleExpandableListAdapter. The resulting List
  * contains one list for each group. Each such second-level group contains
  * Maps. Each such Map contains two keys: "shadeName" is the name of the
  * shade and "rgb" is the RGB value for the shade.
  */
  private List createChildList() {
	ArrayList result = new ArrayList();
	for( int i = 0 ; i < shades.length ; ++i ) {
// Second-level lists
	  ArrayList secList = new ArrayList();
	  for( int n = 0 ; n < shades[i].length ; n += 2 ) {
	    HashMap child = new HashMap();
		child.put( "shadeName", shades[i][n] );
	    child.put( "rgb", shades[i][n+1] );
		secList.add( child );
	  }
	  result.add( secList );
	}
	return result;
  }

}
