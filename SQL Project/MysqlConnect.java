package Package;

import java.sql.*;
import java.util.Scanner;

public class MysqlConnect{
public static void main(String[] args) throws SQLException {
	Scanner sc = new Scanner(System.in);
	System.out.println("MySQL Connect Example");
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/";
	String dbName = "exercise";
	String driver = "com.mysql.jdbc.Driver";
	String userName = "root"; 
	String password = "";

	try{
		Class.forName(driver).newInstance();
		conn = DriverManager.getConnection(url+dbName,userName,password);
		System.out.println("Connected to database");
	}catch(Exception e) {
		e.printStackTrace();
	
	} 

	try{
		
		Statement st = conn.createStatement();
		
		System.out.println("Enter the company's name:");
		String cname = sc.nextLine();
		
		st.execute("INSERT IGNORE INTO company (c_name) VALUES('"+cname+"')");
		System.out.println("Welcome to "+cname+"'s database");
		System.out.println("Enter how many warehouses the company has");
		int count=0;
		count = sc.nextInt();
		sc.nextLine();
		
		for(int i = 0; i<count;i++) {
			System.out.println("Enter the warehouse's code");
			String whcode = sc.nextLine();
			
			if(whcode.length() != 4) {
				do {
					System.out.println("The warehouse code must be 4 english letters!");
					whcode = sc.nextLine();
				}while(whcode.length() != 4);
				
				
			}
			st.executeUpdate("DELETE FROM `warehouse` WHERE 0");
			st.execute("INSERT IGNORE INTO warehouse VALUES('"+cname+"','"+whcode.toUpperCase()+"','0','0000-00-00 00:00:00')");
			
			System.out.println("How many bins the warehouse: "+whcode.toUpperCase()+" has?");
			int Bcount = sc.nextInt();
			sc.nextLine();
			for(int j=1;j<=Bcount;j++) {
				System.out.println("Enter the capacity of bin "+j+")");
				int bincap=sc.nextInt();
				
				st.execute("INSERT IGNORE INTO `bin`(`warehouse_wh_code`, `bin_code`, `capacity`) VALUES ('"+whcode.toUpperCase()+"','"+j+"','"+bincap+"')");
				sc.nextLine();
				
				
			}
			System.out.println("How many batches do we have?");
			int Batchc = sc.nextInt();
			sc.nextLine();
			for(int x=1;x<=Batchc;x++) {
				
				System.out.println("Whats the arrival date of batch "+x);
				String barr = sc.nextLine(); //batch arrival
				System.out.println("Enter the Admin's code that manages this batch");
				String Adcode = sc.nextLine();
				System.out.println("how many parts are there in batch "+x);
				int batchcap = sc.nextInt();
				sc.nextLine();
				st.execute("Insert IGNORE into `admin`(`ad_code`) Select '"+Adcode+"' FROM `admin` WHERE NOT EXISTS(SELECT * FROM `admin` Where `ad_code` = '"+Adcode+"')");
				st.execute("INSERT INTO `batch`(`b_num`, `arr_date`, `cap`, `admin_ad_code`) VALUES ('"+x+"','"+barr+"','"+Batchc+"','"+Adcode+"')");
				for(int y = 0;y<batchcap;y++) {
					System.out.println("Enter the part's code");
					String prcode = sc.nextLine();
					if(prcode.length() != 5) {
						do {
							System.out.println("The part code must be 5 characters long!");
							prcode = sc.nextLine();
						}while(prcode.length() != 4);
						
						
					}
					System.out.println("Is this part a part of an assembled product? Yes/No");
					String ans = sc.nextLine();
					
					
					while(ans.equals("Yes") == false && ans.equals("No") == false) {
						System.out.println("Invalid answer enter Yes or No");
						ans = sc.nextLine();
					}
						
					
					if(ans.equals("Yes")) {
						System.out.println("Enter the code of the resulting product");//ÏƒÏ„Î·Î½ ÎµÎºÏ†Ï‰Î½Î·ÏƒÎ· Î»ÎµÏ„Îµ Ï€Ï‰Ï‚ ÎµÎ¹Î½Î±Î¹ Î±Ï�Î¹Î¸Î¼Î·Ï„Î¹ÎºÎ¿Ï‚ ÎºÏ‰Î´Î¹ÎºÎ¿Ï‚ Î±Î»Î»Î± ÏƒÏ„Î± Î¶Î·Ï„Î¿Ï…Î¼ÎµÎ½Î± Î±Î½Î±Ï†ÎµÏ�ÎµÏƒÏ„Îµ ÏƒÏ„Î¿Î½ ÎºÏ‰Î´Î¹ÎºÎ¿ Ï‰Ï‚ klo98(Î±Î»Ï†Î±Ï�Î¹Î¸Î¼Î·Ï„Î¹ÎºÎ¿)
						String assembledc = sc.nextLine();
						if(assembledc.length() != 5) {
							do {
								System.out.println("The warehouse code must be 5 characters!");
								assembledc = sc.nextLine();
							}while(assembledc.length() != 5);
							
							
						}
						System.out.println("In which bin does this product part belong to?");
						int an = sc.nextInt();
						sc.nextLine();
						st.execute("INSERT INTO `assembled_part`(`ap_code`) VALUES ('"+assembledc+"')");
						st.execute("INSERT IGNORE INTO `product_part`(`p_code`, `bin_bin_code`, `batch_b_num`, `assembled_part_ap_code`) VALUES ('"+prcode+"','"+an+"','"+x+"','"+assembledc+"')");
					}
					else{
						System.out.println("In which bin does this product part belong to?");
						int an = sc.nextInt();
						sc.nextLine();
						st.execute("INSERT IGNORE INTO `product_part`(`p_code`, `bin_bin_code`, `batch_b_num`, `assembled_part_ap_code`) VALUES ('"+prcode+"','"+an+"','"+x+"','none')");
					}
				}
				
			}
		}
		
		System.out.println("1 row affected");
	
	}catch(SQLException s){
		System.out.println("SQL statement is not executed!");
	}

	
	

  
	
	
    try{
		Statement st = conn.createStatement();
		//INSERT COMMENTS THE FIRST TRY WITH INSERT AND AFTER REMOVE THE COMMENTS OF DELETE QUERY.
		// st.execute("Delete  FROM publisher WHERE publisher_code='P888'");		
		ResultSet res = st.executeQuery("SELECT * FROM company");
		
		while (res.next()) {
			
			
			
		}
		}catch(SQLException s){
			System.out.println("SQL code does not execute.");
		} 
    	sc.close();
		conn.close();
//		System.out.println("Disconnected from database");
}
}
