
Sync Database: tetpolycarp@gmail.com - polycarp18
Azure account: chaunguyen1997@yahoo.com - email pwd
Azure machine: btvpolycarp.westus2.cloudapp.azure.com - BTV - chau - iBreakUbuil7 - 51.141.165.19
Church email: btvpolycarp@gmail.com - polycarp14 (github as well btvpolycarp)
Github account: btvpolycarp - polycarp 14
Repo: https://github.com/btvpolycarp/saleorder.git
Machine require to install mongodb for database and SQL Express for security login


Steps: to do when new year
1. Change all the logo and text to new year
2. Update web.config to point to the new database folder
3. On the webserver, udpate the Scheduler job to sync and archive the database folder onto tetpolycarp google drive
4. Create the new google sheet to tract inventory
5. Read the backlog below


Backlogs:
- From the menu, separate out the google sheet and link to Inventory and So nau moi ngay.
- Link inventory of other product into overall number of order/invoice
- Make sure to pay and get service for SMS text
- In Order Detail report, make the filter for Quantity column as well. Also, don't display if the quantity is 0 for Not pickup. Maybe make the logi in Invoice to make it to "Pickup" when the Amount is zero.
- On the Desktop Invoice Page, whenever change the quantity, should turn on AutoPost back to update the page.
- Make sure a way to lock the quantity of the pre-ordered on the last Sunday after we calc everything
- Whataver the invoice paid and transfer money, make sure to provide a way to close it so it won't be able to change like being cancelled. The button to completed should on the Tracking Sheet page.
- Add the page to load all the histories
- When Enter the quantity, refresh post back on invoice page
- Add the way to restore from any histories as possible.
- Try not to implement Security and store in SQL. Try to store in data file as possible
- order detail, performance for slow when click on the filter
- Make a way to easily track TNTT sale. Either use Good sheet, have column for Checkout amount, return amount, so the amount sold. Then convert that in to the invoice. 
   might need to have another radio button for TNTT and make sure the mobile doesn't break. Might be a 1 more radio button for TNTT. When it loads, fillup with all available sale items.
- Make master collection to choose and selet which year to load the data

Fix not:
- Update GoogleSheet with the total pickup automatically
- Order #5 doesn't work (Invoice 142 has incorrect data). Therefore, the Paid Amount is blank, so it doesn't display the check amount correctly. Then make the invoice doesn't display in the CheckSheet

- Display Note on the export in Balance sheet
- Create by is wrong, it shows as the last update

Step to Google Sheet API:
1. Setup API key: https://console.developers.google.com/apis/dashboard
    Tutorial: https://www.youtube.com/watch?v=shctaaILCiU&list=UUm5pREiVM6hwsZKqJww8XuA&index=21
2. 


Y kien for next year:
- Don't accept 100 banh chung deal. Don't make 1 single invoice for many pickup and order like Giao Ly, hay ca doan thieu nhi. If accept it, we need to have a way to track 
better, like break into many different invoices but using the same codes.
- Nhac cac anh chi lay order, phai noi voi khach to deposite so we can keep the order.
- Nguoi nao truc, phai update invoice khi pickup or paid. Hay out of sync voi so sach.
- Co Luan khong biet con o voi Lavang hay khong. Make sure the group know to to work with Polycarp. Make sure they know we have banh tet.
- Usually the last Sunday night before the project end, is the day we can finalize and calucate the number.
- Make it quick and only need 2 week. Usually start Saturday setup. Sunday make nhan dau xanh. Monday goi.
- Khâu wrap bánh chưng rất quan trọng. Cho nguoi thường xuyên coi va chì đạop.
- Liên lạc voi lavang som. Lien lạc với Hằng ớ Hot toc Rex lay banh
- Make sure to have more freezer. 


















Steps to setup the new Web Server to run:
1. Install Visual Studio and SQL Management Studio
2. Pull the sources as above
3. Use SQL Management Studio to create an empty database "SaleOrderUsers". This database is used to store user identities.
   Go to the codes of Account\Register to uncomment the codes to check if the current user have to be Global Admin to browse the page. So we can create the new user that way
4. Change the "DefaultConnection" string in web.config to match with new server. Also, read more for further notes.
	Also, in webconfig, pay attention on   <add key="RootDataDirectory" value="C:\GianHangTet2020" />
	This is used to store all the database file. The database is flat and be all .json files
5. Run VS in admin mode then start SaleOrder.sln. Try to build and make sure to run locally first. 
	Go to RegisterPage to add admin like http://localhost:61429/Account/Register
6. Install IIS: Control Panel -> Turn Window features on or off -> Internet Information Services (Web Management Tools, WWW services)
	Test: http://localhost/
7. From Project in VS, using the existing Profile to publish the codes to C:\inetpub\wwwroot
8.