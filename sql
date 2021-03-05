JAVA:

package com.example.sqlitee;

import android.app.Activity;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
public class MainActivity extends Activity implements OnClickListener
{
    EditText Rollno,Name,Marks;
    Button Insert,Delete,Update,View,ViewAll;
    SQLiteDatabase db;
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Rollno=(EditText)findViewById(R.id.Rollno);
        Name=(EditText)findViewById(R.id.Name);
        Marks=(EditText)findViewById(R.id.Marks);
        Insert=(Button)findViewById(R.id.Insert);
        Delete=(Button)findViewById(R.id.Delete);
        Update=(Button)findViewById(R.id.Update);
        View=(Button)findViewById(R.id.View);
        ViewAll=(Button)findViewById(R.id.ViewAll);

        Insert.setOnClickListener(this);
        Delete.setOnClickListener(this);
        Update.setOnClickListener(this);
        View.setOnClickListener(this);
        ViewAll.setOnClickListener(this);

        // Creating database and table
        db=openOrCreateDatabase("StudentDB", Context.MODE_PRIVATE, null);
        db.execSQL("CREATE TABLE IF NOT EXISTS student(rollno VARCHAR,name VARCHAR,marks VARCHAR);");
    }
    public void onClick(View view)
    {
        // Inserting a record to the Student table
        if(view==Insert)
        {
            // Checking for empty fields
            if(Rollno.getText().toString().trim().length()==0||
                    Name.getText().toString().trim().length()==0||
                    Marks.getText().toString().trim().length()==0)
            {
                showMessage("Error", "Please enter all values");
                return;
            }
            db.execSQL("INSERT INTO student VALUES('"+Rollno.getText()+"','"+Name.getText()+
                    "','"+Marks.getText()+"');");
            showMessage("Success", "Record added");
            clearText();
        }
        // Deleting a record from the Student table
        if(view==Delete)
        {
            // Checking for empty roll number
            if(Rollno.getText().toString().trim().length()==0)
            {
                showMessage("Error", "Please enter Rollno");
                return;
            }
            Cursor c=db.rawQuery("SELECT * FROM student WHERE rollno='"+Rollno.getText()+"'", null);
            if(c.moveToFirst())
            {
                db.execSQL("DELETE FROM student WHERE rollno='"+Rollno.getText()+"'");
                showMessage("Success", "Record Deleted");
            }
            else
            {
                showMessage("Error", "Invalid Rollno");
            }
            clearText();
        }
        // Updating a record in the Student table
        if(view==Update)
        {
            // Checking for empty roll number
            if(Rollno.getText().toString().trim().length()==0)
            {
                showMessage("Error", "Please enter Rollno");
                return;
            }
            Cursor c=db.rawQuery("SELECT * FROM student WHERE rollno='"+Rollno.getText()+"'", null);
            if(c.moveToFirst()) {
                db.execSQL("UPDATE student SET name='" + Name.getText() + "',marks='" + Marks.getText() +
                        "' WHERE rollno='"+Rollno.getText()+"'");
                showMessage("Success", "Record Modified");
            }
            else {
                showMessage("Error", "Invalid Rollno");
            }
            clearText();
        }
        // Display a record from the Student table
        if(view==View)
        {
            // Checking for empty roll number
            if(Rollno.getText().toString().trim().length()==0)
            {
                showMessage("Error", "Please enter Rollno");
                return;
            }
            Cursor c=db.rawQuery("SELECT * FROM student WHERE rollno='"+Rollno.getText()+"'", null);
            if(c.moveToFirst())
            {
                Name.setText(c.getString(1));
                Marks.setText(c.getString(2));
            }
            else
            {
                showMessage("Error", "Invalid Rollno");
                clearText();
            }
        }
        // Displaying all the records
        if(view==ViewAll)
        {
            Cursor c=db.rawQuery("SELECT * FROM student", null);
            if(c.getCount()==0)
            {
                showMessage("Error", "No records found");
                return;
            }
            StringBuffer buffer=new StringBuffer();
            while(c.moveToNext())
            {
                buffer.append("Rollno: "+c.getString(0)+"\n");
                buffer.append("Name: "+c.getString(1)+"\n");
                buffer.append("Marks: "+c.getString(2)+"\n\n");
            }
            showMessage("Student Details", buffer.toString());
        }
    }
    public void showMessage(String title,String message)
    {
        Builder builder=new Builder(this);
        builder.setCancelable(true);
        builder.setTitle(title);
        builder.setMessage(message);
        builder.show();
    }
    public void clearText()
    {
        Rollno.setText("");
        Name.setText("");
        Marks.setText("");
        Rollno.requestFocus();
    }
}

XML:
<?xml version="1.0" encoding="utf-8"?>
<AbsoluteLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:id="@+id/textView"
        android:layout_width="263dp"
        android:layout_height="55dp"
        android:layout_x="42dp"
        android:layout_y="145dp"
        android:fontFamily="sans-serif-black"
        android:text="Student Database"
        android:textSize="24sp"
        tools:layout_editor_absoluteX="72dp"
        tools:layout_editor_absoluteY="55dp" />

    <EditText
        android:id="@+id/Rollno"
        android:layout_width="265dp"
        android:layout_height="62dp"
        android:layout_x="38dp"
        android:layout_y="328dp"
        android:ems="10"
        android:hint="usn"
        android:inputType="textPersonName"
        tools:layout_editor_absoluteX="59dp"
        tools:layout_editor_absoluteY="148dp" />

    <EditText
        android:id="@+id/Name"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_x="42dp"
        android:layout_y="248dp"
        android:ems="10"
        android:hint="name"
        android:inputType="textPersonName"
        tools:layout_editor_absoluteX="66dp"
        tools:layout_editor_absoluteY="251dp" />

    <EditText
        android:id="@+id/Marks"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_x="46dp"
        android:layout_y="422dp"
        android:ems="10"
        android:hint="marks"
        android:inputType="textPersonName"
        tools:layout_editor_absoluteX="59dp"
        tools:layout_editor_absoluteY="343dp" />

    <Button
        android:id="@+id/Insert"
        android:layout_width="134dp"
        android:layout_height="69dp"
        android:layout_x="49dp"
        android:layout_y="491dp"
        android:text="Insert"
        tools:layout_editor_absoluteX="42dp"
        tools:layout_editor_absoluteY="426dp" />

    <Button
        android:id="@+id/Update"
        android:layout_width="122dp"
        android:layout_height="65dp"
        android:layout_x="217dp"
        android:layout_y="491dp"
        android:text="Update"
        tools:layout_editor_absoluteX="224dp"
        tools:layout_editor_absoluteY="430dp" />

    <Button
        android:id="@+id/Delete"
        android:layout_width="119dp"
        android:layout_height="66dp"
        android:layout_x="46dp"
        android:layout_y="564dp"
        android:text="Delete"
        tools:layout_editor_absoluteX="52dp"
        tools:layout_editor_absoluteY="547dp" />

    <Button
        android:id="@+id/ViewAll"
        android:layout_width="126dp"
        android:layout_height="64dp"
        android:layout_x="110dp"
        android:layout_y="651dp"
        android:text="ViewAll"
        tools:layout_editor_absoluteX="150dp"
        tools:layout_editor_absoluteY="641dp" />

    <Button
        android:id="@+id/View"
        android:layout_width="123dp"
        android:layout_height="77dp"
        android:layout_x="213dp"
        android:layout_y="568dp"
        android:text="View"
        tools:layout_editor_absoluteX="220dp"
        tools:layout_editor_absoluteY="533dp" />
</AbsoluteLayout>
