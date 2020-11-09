# **Pewlett-Hackard-Analysis**
SQL Application
- Entity Diagram Relationship
- Data table management and analysis

## **Purpose** 
The **Pewlett-Hackard** Human Resources committee requested analysis of the company organizational data to determine how many employees are nearing retirement to help plan for 2020 hiring and a new mentorship initiative. In this database management implementation, fragmented datasheets are integrated to produce critical data tables that will enable analytics required to explore the hiring and mentorship program needs. 
#
This report comprises:
- **Entity Diagram Relationship:** *map of company data from separate sources*
- **# of Retiring Employees by Title:** *position vacancies expected in next 3 years*
- **Employees Eligible for the Mentorship Program:** *experts near retirement who can serve as mentors to newer employees*
- **Results**
- **Summary**
- **Additional Findings**
#
These data are critical to Pewlett-Hackard's planning process filling vacancies and fostering the transfer of knowledge to newer employees. 

## Data
- departments.csv, employees.csv, salaries.csv, titles.csv, dept_emp.csv, dept_manager.csv
- Software: PostgreSQL 11

## Resources
![Entity Diagram Relationship](https://github.com/zborglin/Pewlett-Hackard-Analysis/blob/main/Resources/ERD.png)
### Figure 1: Entity Diagram Relationship
![# of Retiring Employees by Title](https://github.com/zborglin/Pewlett-Hackard-Analysis/blob/main/Resources/retiring_titles.png)
### Figure 2: # of Retiring Employees by Title

## Results
Four key observations can be made form the data table referenced in Figure 1 and Figure 2:
1. Nearly 30,000 senior engineers are set to retire in the next three years, presenting a huge risk of losing technical capabilities in the near term.
2. 2 department managers who oversee 1000's of employees each as well as guide strategic imperatives for their respective departments are set to retire. Succession planning will be integral to the successful transfer of these roles in the next few years. 
3. There are many employees across many titles set to retire soon, so mentor roles are possible for each job type.
4. Over 1500 employees are eligible for the mentorship initiative as they will retire in the next 6th months. It is important to intitiate their involvement in the program so they can allocate the appopriate amount of time to ensure program success.

## Summary
Approximately 90,000 employees can be expected to retire in the next 3 years as part of the "silver tsunami" event. About 1500 employees fit the criteria for the mantership program role which is unlikely to be sufficient to train the influx of new employees. As more retire and agree to the mentor role, the number of training opportunities can be expected to increase. 

## Additional Findings
The following figures show recommendations for additional investigation.
![# of Retiring Employees by Dept ID](https://github.com/zborglin/Pewlett-Hackard-Analysis/blob/main/Resources/retiring_dept.png)
### Figure 2: # of Retiring Employees by Dept ID

- The data table above shows which departments are expecting the most number of retirees in the next three years. Looking at the quantities by department ID can help the business plan fund allocation for hiring purposes.

![Salary Irregularities](https://github.com/zborglin/Pewlett-Hackard-Analysis/blob/main/Resources/emp_info.png)
### Figure 4: Salary Irregularities

- While looking through the employee data, several irregularities were found that deserve some attention. For example, it is suspected that salaries are being mismanaged due to outliers detected with correlation analysis between titles and years of service. The exact details of the findings will be discussed in a different format to respect employee privacy. 