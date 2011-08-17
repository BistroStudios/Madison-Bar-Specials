package main.index;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import android.app.Activity;
import android.os.Bundle;
import android.widget.BaseExpandableListAdapter;
import android.widget.ExpandableListAdapter;
import android.widget.ExpandableListView;
import android.widget.SimpleExpandableListAdapter;
import android.view.View;

public class MadisonBarSpecialsActivity extends Activity {
	
    static final String bars[] = {
  	  "grey",
  	  "blue",
  	  "yellow",
  	  "red"
  	};

  	static final String specials[][] = {
  // Shades of grey
  	  {
  		"lightgrey","#D3D3D3",
  		"dimgray","#696969",
  		"sgi gray 92","#EAEAEA"
  	  },
  // Shades of blue
  	  {
  		"dodgerblue 2","#1C86EE",
  		"steelblue 2","#5CACEE",
  		"powderblue","#B0E0E6"
  	  },
  // Shades of yellow
  	  {
  		"yellow 1","#FFFF00",
  		"gold 1","#FFD700",
  		"darkgoldenrod 1","	#FFB90F"
  	  },
  // Shades of red
  	  {
  		"indianred 1","#FF6A6A",
  		"firebrick 1","#FF3030",
  		"maroon","#800000"
  	  }
      };
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // initialize our bar list
        ExpandableListView barListView = (ExpandableListView) findViewById(R.id.barList);
        
        SimpleExpandableListAdapter expListAdapter =
        	new SimpleExpandableListAdapter(
				this,
				createGroupList(),	// groupData describes the first-level entries
				R.layout.group_row,	// Layout for the first-level entries
				new String[] { "barName" },	// Key in the groupData maps to display
				new int[] { R.id.groupname },		// Data under "barName" key goes into this TextView
				createChildList(),	// childData describes second-level entries
				R.layout.child_row,	// Layout for second-level entries
				new String[] { "specialName", "specialPrice" },	// Keys in childData maps to display
				new int[] { R.id.childname, R.id.price }	// Data under the keys above go into these TextViews
			);
        barListView.setAdapter(expListAdapter);
        
        barListView.setOnGroupClickListener(new ExpandableListView.OnGroupClickListener() {
            @Override
            public boolean onGroupClick(ExpandableListView arg0, View arg1,
                int groupPosition, long arg3) {
            if (groupPosition == 5) {               

            }
            return false;
            }
        });

        barListView.setOnChildClickListener(new ExpandableListView.OnChildClickListener() {
	        @Override
	        public boolean onChildClick(ExpandableListView parent,
	                View v, int groupPosition, int childPosition,
	                long id) {
	            if (groupPosition == 0 && childPosition == 0) {
	               
	            }
	            return false;
	        }
        });
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
	   	  for( int n = 0 ; n < specials[i].length ; n += 2 ) {
	   	    HashMap child = new HashMap();
	   		child.put( "specialName", specials[i][n] );
	   	    child.put( "specialPrice", specials[i][n+1] );
	   		secList.add( child );
	   	  }
	   	  result.add( secList );
	   	}
	   	return result;
     }
    
}