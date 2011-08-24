package main.bars;

import android.app.ExpandableListActivity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.SimpleExpandableListAdapter;
import android.widget.TextView;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Bars_List extends ExpandableListActivity {
    private String bars[];
	private String specials[][];

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
        
        // find the day for the list
    	// 0:Sun,1:Mon,2:Tue,3:Wed,4:Thurs,5:Fri,6:Sat
        makeBarList((new Date()).getDay());
    }
    
    private void makeBarList(int dow) {
    	// set up bar list
        bars = barList();
		
		// set up specials list
		String[] daySpecials = barSpecials(dow);
		ArrayList<String[]> list = new ArrayList<String[]>();
			String delim = "\t";
			for(int i=0;i<daySpecials.length;i++)	{
				String temp = daySpecials[i];
				String[] tokens = temp.split(delim);
				for (int j = 0; j<tokens.length; j++) {
					if (tokens[j].equals("")) {
						tokens[j]=null;
					}
				}
				list.add(tokens);
			}
			
		
		String[][] barSp = new String[list.size()][10]; {
			for (int i=0; i<list.size(); i++)	{
				barSp[i] = list.get(i);
			}
		}
		specials = barSp;
        
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
	  for( int n = 0 ; n < specials[i].length && specials[i][n] != null ; ++n ) {
	    HashMap child = new HashMap();
		child.put( "specialName", specials[i][n] );
		secList.add( child );
	  }
	  result.add( secList );
	}
	return result;
  }
  
  static public String[] barList()
  { 
	   ArrayList<String> bars = new ArrayList<String>();
	   Scanner scan;
	   try{
		   URL url = new URL("https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/BarsList.txt");
		   InputStream in = url.openStream();
		   scan = new Scanner(new InputStreamReader(in));
		   while(scan.hasNextLine())
		   {
			   bars.add(scan.nextLine());
		   }
		   scan.close();
	   }
	   catch (Exception e) {
	       e.printStackTrace();
	   }
	   
	   String[] arr = bars.toArray(new String[0]);
	   return arr;
  }
 
  static public String[] barSpecials(int dow)
  { 
	   ArrayList<String> barSpecials = new ArrayList<String>();
	   Scanner scan;
	   try{
		   // can be null...since dow MUST be 0..6 and thus url WILL be set
		   URL url = null;
		   switch (dow) {
		   	case 0:
		   	case 1:
		   	case 2:
		   	case 3:
		   	case 4:
		   	case 5:
		   	case 6:
		   		url = new URL("https://raw.github.com/BistroStudios/Madison-Bar-Specials/master/MondaySpecials.txt");
		   		break;
		   }
		   InputStream in = url.openStream();
		   scan = new Scanner(new InputStreamReader(in));
		   while(scan.hasNextLine())
		   {
			   barSpecials.add(scan.nextLine());
		   }
		   scan.close();
	   }
	   catch (Exception e) {
	       e.printStackTrace();
	   }
	   
	   String[] arr2 = barSpecials.toArray(new String[0]);
	   return arr2;
  }
  
}