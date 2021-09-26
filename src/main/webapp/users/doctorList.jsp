<%@ page import="com.ua.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="loc" uri="http://com.ua/FinalProject" %>

<head>
    <script>
        document.getElementById("defaultOpen").click();

        function openCity(evt, login) {

            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(login).style.display = "block";
            evt.currentTarget.className += " active";
        }

        function openCity2(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent2");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks2");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";

            var acc = document.getElementsByClassName("accordion");
            var i;

            for (i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var panel = this.nextElementSibling;
                    if (panel.style.maxHeight) {
                        panel.style.maxHeight = null;
                    } else {
                        panel.style.maxHeight = panel.scrollHeight + "px";
                    }
                });
            }
        }
    </script>
    <style>
        @import url(/users/css/doctorList_center2.css);
        @import url(/users/css/table_case_record.css);
        /*@import url(/users/css/newLogin_blank2.css);*/
        @import url(/users/css/list.css);

        table {
            font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
            font-size: 14px;
            background: white;
            max-width: 98%;
            width: 98%;
            border-collapse: collapse;
            text-align: left;
        }

        #nav {
            width: 100%;
            float: right;
            margin: -112px 0 1em 0;
            padding: 0;
            list-style: none;
            background-color: #f2f2f2;
            border-bottom: 1px solid #ccc;
            border-top: 1px solid #ccc;
        }

        #nav li.right {
            float: left;
        }

        #nav li.right p {
            display: block;
            padding: 8px 16px;
            text-decoration: none;
            font-weight: bold;
            border-right: 1px solid #ccc;
        }

        #nav li.right p:hover {
            color: #c00;
            background-color: #fff;
        }

        a {
            text-decoration: none;
        }

        #nav li.left {
            float: right;
        }

        #nav li.left p {
            display: block;
            padding: 8px 16px;
            text-decoration: none;
            font-weight: bold;
            border-left: 1px solid #ccc;
        }

        #nav li.left p:hover {
            color: #c00;
            background-color: #fff;
        }

        .login-page {
            width: 100%;
            padding: 5% 5% 5% 5%;
            margin: auto;
            text-align: left;
        }

        .shine-button {
            text-decoration: none;
            display: inline-block;
            padding: 10px 30px;
            margin: 10px 20px;
            position: relative;
            overflow: hidden;
            border: 2px solid rgba(114, 212, 202, 1);
            border-radius: 8px;
            font-family: 'Montserrat', sans-serif;
            color: GREEN;
            transition: .2s ease-in-out;
            float: end;
        }

        .shine-button:before {
            content: "";
            background: linear-gradient(90deg, rgba(255, 255, 255, .1), rgba(255, 255, 255, .5));
            height: 50px;
            width: 50px;
            position: absolute;
            top: -8px;
            left: -75px;
            transform: skewX(-45deg);
        }

        .shine-button:hover {
            background: rgba(114, 212, 202, 1);
            color: #fff;
        }

        .shine-button:hover:before {
            left: 150px;
            transition: .5s ease-in-out;
        }

        .selcls {
            padding: 9px;
            margin: 0px 0px 15px;
            border: solid 1px Black;
            outline: 0;
            background: #f1f1f1;
            align-content: center;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            -moz-box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 8px;
            border-radius: 8px;
            width: 23%;
        }

        body {
            background: #ebebeb; /* fallback for old browsers */
            font-family: 'Open Sans', Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .letter {
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            margin: 120px auto 0;
            max-width: 70%;
            min-height: 600px;
            padding: 18px;
            position: relative;
            width: 80%;
        }

        .letter:before, .letter:after {
            content: "";
            height: 98%;
            position: absolute;
            width: 100%;
            z-index: -1;
        }

        .letter:before {
            background: #fafafa;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            left: -5px;
            top: 4px;
            transform: rotate(-2.5deg);
        }

        .letter:after {
            background: #f6f6f6;
            box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
            right: -3px;
            top: 1px;
            transform: rotate(1.4deg);
        }

        .hr-shadow {
            margin: 20px 0;
            padding: 0;
            height: 10px;
            border: none;
            border-top: 1px solid #333;
            box-shadow: 0 10px 10px -10px #8c8b8b inset;
        }

    </style>
</head>
<body>
<ul id="nav">
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Staff')" id="defaultOpen">
        <loc:print key="Head_Button_Doctor"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Nurse')">
        <loc:print key="Head_Button_Nurse"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Patient')">
        <loc:print key="Head_Button_Patient"/></p></li>
    <li class="right"><p class="tablinks2" onclick="openCity2(event, 'Archive')">
        <loc:print key="Head_Button_Archive"/></p></li>

    <li class="left"><p><a href="/controller?command=exit">
        <loc:print key="Head_Button_Exit"/></a></p></li>
    <c:forTokens items="${initParam['locales']}"
                 var="locale" delims=" ">
        <li class="left">
            <p>
                <a href="/changeLocale.jsp?localeToSet=${locale}&pageToForward=users/doctorList.jsp&basename=message_${locale}">
                    <img src="/${locale}.png" width="20" height="20"></a></p>
        </li>
    </c:forTokens>
    <li class="left"><p>
        <loc:print key="Head_Button_Login"/>${globalLogin}</p></li>
    <li class="left"><p><a href="/controller?command=viewStaff">
        <loc:print key="Head_Button_Refresh"/></a></p></li>
</ul>
<div class="letter">
    <div class="login-page">
        <div class="form">
            <div id="Staff" class="tabcontent2">
                <div class="button">
                    <p align="left">
                    <form class="button" action="/controller" method="get">
                        <select name="sort" class="selcls">
                            <option value="name"><loc:print key="Sorted_By_Name"/></option>
                            <option value="count"><loc:print key="Sorted_By_Patients"/></option>
                        </select>
                        <select name="categorize" class="selcls">
                            <option value="all" selected><loc:print key="All"/></option>
                            <c:forEach items="${departments}" var="entry">
                                <option value="${entry.getDescription()}">${entry.getDescription()}</option>
                            </c:forEach>
                        </select>
                        <button class="shine-button" type="submit" name="command" value="sortDoctorList" width="100%">
                            <loc:print key="Sorted"/>
                        </button>
                        <button class="shine-button" type="submit" name="command" value="redirect" width="100%">
                            <loc:print key="Add_Employee"/>
                        </button>
                        <input name="address" value="users/newLogin.jsp" hidden>
                    </form>
                    </p>
                </div>
                <table align="center">
                    <output>
                        <tr class="table1">
                            <th class="table1" width="5%">id</th>
                            <th class="table1" width="15%"><loc:print key="Login"/></th>
                            <th class="table1" width="22%"><loc:print key="Name_Anketa"/></th>
                            <th class="table1" width="22%"><loc:print key="Surname_Anketa"/></th>
                            <th class="table1" width="26%"><loc:print key="Department_Anketa"/></th>
                            <th class="table1"><loc:print key="Details"/></th>
                        </tr>
                        <c:forEach items="${doctors}" var="entry" varStatus="i">
                            <tr class="table1">
                                <th class="table1">${i.count}</th>
                                <th class="table1">${entry.getLogin()}</th>
                                <th class="table1">${entry.getName()}</th>
                                <th class="table1">${entry.getSurname()}</th>
                                <th class="table1">${entry.getDepartment()} (${entry.getCaseRecords().size()} -
                                    <loc:print key="Patient_Anketa"/>)
                                </th>
                                <th class="table1"></th>
                            </tr>
                        </c:forEach>
                    </output>
                </table>
                <hr class="hr-shadow">
                <table align="center">
                    <output>
                        <tr class="table1">
                            <th class="table1" width="5%">id</th>
                            <th class="table1" width="15%"><loc:print key="Login"/></th>
                            <th class="table1" width="22%"><loc:print key="Name_Anketa"/></th>
                            <th class="table1" width="22%"><loc:print key="Surname_Anketa"/></th>
                            <th class="table1" width="26%"><loc:print key="Department_Anketa"/></th>
                            <th class="table1"><loc:print key="Details"/></th>
                        </tr>
                        <c:forEach items="${nurses}" var="entry" varStatus="i">
                           <tr>
                               <th class="table1">${i.count}</th>
                               <th class="table1">${entry.getLogin()}</th>
                               <th class="table1">${entry.getName()}</th>
                               <th class="table1">${entry.getSurname()}</th>
                               <th class="table1"><loc:print key="Head_Button_Nurse"/></th>
                               <th class="table1"></th>
                           </tr>
                        </c:forEach>
                    </output>
                </table>
                <%--                <c:forEach items="${doctors}" var="entry">--%>
                <%--                    <div id="${entry.getLogin()}" class="tabcontent" hidden>--%>
                <%--                        <output>--%>
                <%--                            <i><p class="login"><loc:print key="Login_Anketa"/>${entry.getLogin()}</p>--%>
                <%--                                <p><loc:print key="Passport_Anketa"/> : ${entry.getPassport()}</p>--%>
                <%--                                <p><loc:print key="Name_Anketa"/> : ${entry.getName()}</p>--%>
                <%--                                <p><loc:print key="Surname_Anketa"/> : ${entry.getSurname()}</p>--%>
                <%--                                <p><loc:print key="Telephone_Anketa"/> : ${entry.getTelephone()}</p>--%>
                <%--                                <p><loc:print key="Department_Anketa"/> : ${entry.getDepartment()}</p>--%>
                <%--                                <p><loc:print key="Patient_Case_Anketa"/> :</p>--%>
                <%--                                <c:forEach items="${entry.getCaseRecords()}" var="card">--%>
                <%--                                    <pre>    ${card.getPatient().getName()} ${card.getPatient().getSurname()}(${card.getInitialDiagnosis()})</pre>--%>
                <%--                                </c:forEach>--%>
                <%--                            </i>--%>
                <%--                        </output>--%>
                <%--                    </div>--%>
                <%--                </c:forEach>--%>

            </div>
            <hr class="hr-shadow">
            <div id="Nurse" class="tabcontent2">
                <div class="tab">
                    <ol class="rounded">
                        <c:forEach items="${nurses}" var="patient">
                            <li>
                                <a href="#" class="tablinks"
                                   onclick="openCity(event, '${patient.getLogin()}')"> ${patient.getName()}
                                        ${patient.getSurname()}</a>
                            </li>
                        </c:forEach>
                    </ol>
                </div>
                <%--                <c:forEach items="${nurses}" var="patient">--%>
                <%--                    <div id="${patient.getLogin()}" class="tabcontent" hidden>--%>
                <%--                        <output>--%>
                <%--                            <i><p class="login"><loc:print key="Login_Anketa"/>${patient.getLogin()}</p>--%>
                <%--                                <p><loc:print key="Passport_Anketa"/> : ${patient.getPassport()}</p>--%>
                <%--                                <p><loc:print key="Name_Anketa"/> : ${patient.getName()}</p>--%>
                <%--                                <p><loc:print key="Surname_Anketa"/> : ${patient.getSurname()}</p>--%>
                <%--                                <p><loc:print key="Telephone_Anketa"/> : ${patient.getTelephone()}</p>--%>
                <%--                            </i>--%>
                <%--                        </output>--%>
                <%--                    </div>--%>
                <%--                </c:forEach>--%>
            </div>
            <form class="button" action="/controller" method="get">
                <select name="sort2" class="selcls">
                    <option value="sortByName"><loc:print key="Sorted_By_Name"/></option>
                    <option value="sortByBirthday"><loc:print key="Sorted_By_Age"/></option>
                </select>
                <button class="shine-button" type="submit" name="command" value="sortPatientList" width="100%">
                    <loc:print key="Sorted"/>
                </button>
                <input name="address" value="users/newPatient.jsp" hidden>
                <button class="shine-button" type="submit" name="command" value="redirect" width="100%">
                    <loc:print key="Add_Patient"/>
                </button>
            </form>
            <div id="Patient" class="tabcontent2">
                <table align="center">
                    <output>
                        <tr class="table1">
                            <th class="table1" width="5%">id</th>
                            <th class="table1" width="20%"><loc:print key="Name_Anketa"/> <loc:print key="Surname_Anketa"/></th>
                            <th class="table1" width="15%"><loc:print key="Birthday_Anketa"/></th>
                            <th class="table1" width="20%"><loc:print key="Provisional_Diagnosis"/></th>
                            <th class="table1" width="20%"><loc:print key="Attending_Physician_Anketa"/></th>
                            <th class="table1"><loc:print key="Details"/></th>
                        </tr>
                        <c:forEach items="${caseRecordList}" var="entry" varStatus="i">
                            <tr>
                                <th class="table1">${i.count}</th>
                                <th class="table1">${entry.getPatient().getName()} ${entry.getPatient().getSurname()}</th>
                                <th class="table1">${entry.getPatient().getYearBorn()}/${entry.getPatient().getMonthBorn()}/${entry.getPatient().getDayBorn()}
                                    (${entry.getPatient().getYears()})</th>
                                <th class="table1">${entry.getInitialDiagnosis()}</th>
                                <th class="table1">${entry.getDoctor().getName()} ${entry.getDoctor().getSurname()}</th>
                                <th class="table1"></th>
                            </tr>
                        </c:forEach>
                    </output>
                </table>

<%--                <c:forEach items="${caseRecordList}" var="patient">--%>
<%--                    <div id="${patient.getId()}" class="tabcontent" hidden>--%>
<%--                        <i><p><loc:print key="Passport_Anketa"/>${patient.getPassport()}</p>--%>
<%--                            <p><loc:print key="Birthday_Anketa"/>--%>
<%--                                : ${patient.getDayBorn()}-${patient.getMonthBorn()}-${patient.getYearBorn()}(${patient.getYears()})</p>--%>
<%--                            <p><loc:print key="Name_Anketa"/> : ${patient.getName()}</p>--%>
<%--                            <p><loc:print key="Surname_Anketa"/> : ${patient.getSurname()}</p>--%>
<%--                            <p><loc:print key="Telephone_Anketa"/> : ${patient.getTelephone()}</p>--%>
<%--                            <c:forEach items="${patient.getCaseRecords()}" var="card">--%>
<%--                                <p class="MyMarginLeft"><loc:print--%>
<%--                                        key="Diagnosis_Anketa"/>(${card.getInitialDiagnosis()})--%>
<%--                                    <loc:print key="Attending_Physician_Anketa"/>--%>
<%--                                    <c:if test="${card.getDoctor().getName() != null}">--%>
<%--                                        ${card.getDoctor().getName()} ${card.getDoctor().getSurname()}--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${card.getDoctor().getName() == null}">--%>
<%--                                        <loc:print key="Not_Available"/>--%>
<%--                                    </c:if>--%>
<%--                                </p>--%>
<%--                            </c:forEach>--%>
<%--                        </i>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
                <form class="button" action="/controller" method="get">
                    <input name="command" value="addNewPatient" hidden>
                    <p align="left"><input type="submit" value="<loc:print key="Add_Patient"/>"></p>
                </form>
                <div class="button">
                    <p align="left">
                    <form>
                        <input name="command" value="sortPatientList" hidden>
                        <c:if test="${sort2=='sortByName'|| sort2==null}">
                            <label><input type="radio" name="sort2" value="sortByName" checked>
                                <loc:print key="Sorted_By_Name"/></label><br>
                            <label><input type="radio" name="sort2" value="sortByBirthday">
                                <loc:print key="Sorted_By_Age"/></label><br>
                        </c:if>
                        <c:if test="${sort2=='sortByBirthday'}">
                            <label><input type="radio" name="sort2" value="sortByName">
                                <loc:print key="Sorted_By_Name"/></label><br>
                            <label><input type="radio" name="sort2" value="sortByBirthday" checked>
                                <loc:print key="Sorted_By_Age"/></label><br>
                        </c:if>
                        <input type="submit" value="<loc:print key="Sorted"/>">
                    </form>
                    <form class="button" action="/controller" method="post">
                        <p>Назначить врача пациенту</p>
                        <input name="command" value="doctorToPatient" hidden>
                        <p><select name="selectDoctor">
                            <c:forEach items="${doctors}" var="patient">
                                <option value="${patient.getId()}">${patient.getName()}
                                        ${patient.getSurname()} - ${patient.getDepartment()}</option>
                            </c:forEach>
                        </select>
                            <select name="selectPatient">
                                <c:forEach items="${patients}" var="patient">
                                    <c:forEach items="${patient.getCaseRecords()}" var="diagnose">
                                        <c:if test="${diagnose.getDoctor().getName()==null}">
                                            <option value="${diagnose.getId()}">${patient.getName()}
                                                    ${patient.getSurname()} - ${diagnose.getInitialDiagnosis()}</option>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </select></p>
                        <input type="submit" value="<loc:print key="Assignment"/>">
                    </form>
                </div>
            </div>

            <div id="Archive" class="tabcontent2">
                <table align="center">
                    <tr class="table1">
                        <th class="table1" width="5%">id</th>
                        <th class="table1" width="15%"><loc:print key="Passport_Anketa"/></th>
                        <th class="table1" width="20%"><loc:print key="Patient_Anketa"/></th>
                        <th class="table1" width="23%"><loc:print key="Provisional_Diagnosis"/></th>
                        <th class="table1" width="22%"><loc:print key="Final_Diagnosis"/></th>
                        <th class="table1"><loc:print key="Medical_Appointments"/></th>
                    </tr>
                    <c:forEach items="${archivePatient}" var="patient">
                        <c:if test="${patient.getCaseRecords().size() != 0}">
                            <c:forEach items="${patient.getCaseRecords()}" var="cr" varStatus="i">
                                <tr class="table1">
                                    <td class="table1">${i.count}</td>
                                    <td class="table1">${patient.getPassport()}</td>
                                    <td class="table1">${patient.getName()} ${patient.getSurname()}</td>
                                    <td class="table1">${cr.getInitialDiagnosis()}</td>
                                    <td class="table1">${cr.getFinalDiagnosis()}</td>
                                    <td class="table1"><a
                                            href="/controller?command=archiveAppointment&appointmentId=${cr.getId()}">Подробно</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen").click();
</script>
</body>
</html>