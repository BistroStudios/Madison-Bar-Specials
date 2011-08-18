package aexp.explist;

import android.app.ExpandableListActivity;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.style.UnderlineSpan;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
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
    static final String bars[] = {
	  "Jordan's Big 10 Pub",
	  "Lucky's",
	  "Wando's",
	  "Brothers"
	};

	static final String specials[][] = {
// Jordan's Specials
	  {
		"2-for-1 Rails",
		"$1 PBR"
	  },
// Lucky's Specials
	  {
		"dodgerblue 2",
		"steelblue 2",
		"powderblue"
	  },
// Wando's Specials
	  {
		"yellow 1",
		"gold 1",
		"darkgoldenrod 1",
	  },
// Brothers' Specials
	  {
		"indianred 1",
		"firebrick 1",
		"maroon"
	  }
    };
	
	// Create an anonymous implementation of OnClickListener
	private OnClickListener filterListener = new OnClickListener() {
	    public void onClick(View v) {
	      // do something when the button is clicked
	    }
	};
	
	// Create an anonymous implementation of OnClickListener
	private OnClickListener sortListener = new OnClickListener() {
	    public void onClick(View v) {
	      // do something when the button is clicked
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
		currentDateText.setText("Specials for " + format.format(now));
        
        // Set up bar list
		SimpleExpandableListAdapter expListAdapter =
			new SimpleExpandableListAdapter(
				this,
				createGroupList(),	// groupData describes the first-level entries
				R.layout.group_row,	// Layout for the first-level entries
				new String[] { "barName" },	// Key in the groupData maps to display
				new int[] { R.id.groupname },		// Data under "colorName" key goes into this TextView
				createChildList(),	// childData describes second-level entries
				R.layout.child_row,	// Layout for second-level entries
				new String[] { "specialName" },	// Keys in childData maps to display
				new int[] { R.id.childname }	// Data under the keys above go into these TextViews
			);
		setListAdapter( expListAdapter );
		
		// Set the filter's link
		Button filter = (Button) findViewById(R.id.filterLink);
	    // Register the onClick listener with the implementation above
	    filter.setOnClickListener(filterListener);
	    
	    // Set the sort's link
		Button sort = (Button) findViewById(R.id.sortLink);
	    // Register the onClick listener with the implementation above
		sort.setOnClickListener(sortListener);
    }

/**
  * Creates the group list out of the colors[] array according to
  * the structure required by SimpleExpandableListAdapter. The resulting
  * List contains Maps. Each Map contains one entry with key "colorName" and
  * value of an entry in the colors[] array.
  */
	private List createGroupList() {
	  ArrayList result = new ArrayList();
	  for( int i = 0 ; i < bars.length ; ++i ) {
		HashMap m = new HashMap();
	    m.put( "barName",bars[i] );
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
	for( int i = 0 ; i < specials.length ; ++i ) {
// Second-level lists
	  ArrayList secList = new ArrayList();
	  for( int n = 0 ; n < specials[i].length ; ++n ) {
	    HashMap child = new HashMap();
		child.put( "specialName", specials[i][n] );
		secList.add( child );
	  }
	  result.add( secList );
	}
	return result;
  }

}
