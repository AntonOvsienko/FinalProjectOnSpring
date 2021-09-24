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
        @import url(/users/css/doctorList_center.css);
        @import url(/users/css/highBanner.css);
        /*@import url(/users/css/table_case_record.css);*/
        /*@import url(/users/css/newLogin_blank2.css);*/
        @import url(/users/css/list.css);

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
                    <form class="button" action="/controller" method="post">
                        <input name="command" value="doctorToPatient" hidden>
                        <p><select name="type sort" class="selcls">
                            <option value="name"><loc:print key="Sorted_By_Name"/></option>
                            <option value="count"><loc:print key="Sorted_By_Patients"/></option>
                        </select>
                            <select name="categorize" class="selcls">
                                <c:forEach items="${departments}" var="entry">
                                    <option value="${entry.getDescription()}">${entry.getDescription()}</option>
                                </c:forEach>
                            </select>
                            <input type="submit" class="shine-button" value="<loc:print key="Sorted"/>">
                            <input name="command" value="sortDoctorList" hidden></p>
                    </form>
                    </p>
                </div>
                <form action="/controller" method="post">
                    <c:if test="${check == 'on'}">
                        <div class="tab">
                            <ol class="rounded">
                                <c:forEach items="${departments}" var="department">
                                    <li><b>${department.description}</b>
                                        <ol class="rounded">
                                            <c:forEach items="${doctors}" var="entry">
                                                <c:if test="${entry.getDepartment() == department.description }">
                                                    <li><a href="#" class="tablinks" id="font"
                                                           onclick="openCity(event, '${entry.getLogin()}')"> ${entry.getName()}
                                                            ${entry.getSurname()}</a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ol>
                                    </li>
                                </c:forEach>
                            </ol>
                        </div>
                    </c:if>
                    <c:if test="${check != 'on'}">
                        <div class="tab">
                            <ol class="square">
                                <c:forEach items="${doctors}" var="entry">
                                    <li><a href="#" class="tablinks"
                                           onclick="openCity(event, '${entry.getLogin()}')"> ${entry.getName()}
                                            ${entry.getSurname()}</a></li>
                                </c:forEach>
                            </ol>
                        </div>
                    </c:if>
                    <c:forEach items="${doctors}" var="entry">
                        <div id="${entry.getLogin()}" class="tabcontent" hidden>
                            <output>
                                <i><p class="login"><loc:print key="Login_Anketa"/>${entry.getLogin()}</p>
                                    <p><loc:print key="Passport_Anketa"/> : ${entry.getPassport()}</p>
                                    <p><loc:print key="Name_Anketa"/> : ${entry.getName()}</p>
                                    <p><loc:print key="Surname_Anketa"/> : ${entry.getSurname()}</p>
                                    <p><loc:print key="Telephone_Anketa"/> : ${entry.getTelephone()}</p>
                                    <p><loc:print key="Department_Anketa"/> : ${entry.getDepartment()}</p>
                                    <p><loc:print key="Patient_Case_Anketa"/> :</p>
                                    <c:forEach items="${entry.getCaseRecords()}" var="card">
                                        <pre>    ${card.getPatient().getName()} ${card.getPatient().getSurname()}(${card.getInitialDiagnosis()})</pre>
                                    </c:forEach>
                                </i>
                            </output>
                        </div>
                    </c:forEach>
                    <div class="button">
                        <table>
                            <tr>
                                <td>
                                    <button type="submit" name="command" value="deleteDoctor" width="100%">
                                        <loc:print key="Delete_Employee"/>
                                    </button>
                                </td>
                                <td>
                                    <button type="submit" name="command" value="redirect" width="100%">
                                        <loc:print key="Add_Employee"/>
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input name="address" value="users/newLogin.jsp" hidden>
                </form>

            </div>

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
                <c:forEach items="${nurses}" var="patient">
                    <div id="${patient.getLogin()}" class="tabcontent" hidden>
                        <output>
                            <i><p class="login"><loc:print key="Login_Anketa"/>${patient.getLogin()}</p>
                                <p><loc:print key="Passport_Anketa"/> : ${patient.getPassport()}</p>
                                <p><loc:print key="Name_Anketa"/> : ${patient.getName()}</p>
                                <p><loc:print key="Surname_Anketa"/> : ${patient.getSurname()}</p>
                                <p><loc:print key="Telephone_Anketa"/> : ${patient.getTelephone()}</p>
                            </i>
                        </output>
                    </div>
                </c:forEach>
            </div>

            <div id="Patient" class="tabcontent2">
                <div class="tab">
                    <ol class="rounded">
                        <c:forEach items="${patients}" var="patient">
                            <li>
                                <a href="#" class="tablinks"
                                   onclick="openCity(event, '${patient.getId()}')"> ${patient.getName()}
                                        ${patient.getSurname()}</a>
                            </li>
                        </c:forEach>
                    </ol>
                </div>

                <c:forEach items="${patients}" var="patient">
                    <div id="${patient.getId()}" class="tabcontent" hidden>
                        <i><p><loc:print key="Passport_Anketa"/>${patient.getPassport()}</p>
                            <p><loc:print key="Birthday_Anketa"/>
                                : ${patient.getDayBorn()}-${patient.getMonthBorn()}-${patient.getYearBorn()}(${patient.getYears()})</p>
                            <p><loc:print key="Name_Anketa"/> : ${patient.getName()}</p>
                            <p><loc:print key="Surname_Anketa"/> : ${patient.getSurname()}</p>
                            <p><loc:print key="Telephone_Anketa"/> : ${patient.getTelephone()}</p>
                            <c:forEach items="${patient.getCaseRecords()}" var="card">
                                <p class="MyMarginLeft"><loc:print
                                        key="Diagnosis_Anketa"/>(${card.getInitialDiagnosis()})
                                    <loc:print key="Attending_Physician_Anketa"/>
                                    <c:if test="${card.getDoctor().getName() != null}">
                                        ${card.getDoctor().getName()} ${card.getDoctor().getSurname()}
                                    </c:if>
                                    <c:if test="${card.getDoctor().getName() == null}">
                                        <loc:print key="Not_Available"/>
                                    </c:if>
                                </p>
                            </c:forEach>
                        </i>
                    </div>
                </c:forEach>
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