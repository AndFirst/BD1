import oracle.jdbc.pool.OracleDataSource;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class App {
    Connection connection;

    public static void main(String[] args) {
        App app = new App();
        try {
            app.setConnection();

            String menu = "1 - utwórz grupę \n" +
                    "2 - dodaj studenta do istniejącej grupy\n" +
                    "3 - wystaw ocenę studentowi\n" +
                    "4 - oblicz średnią ocen studenta\n" +
                    "5 - oblicz sumę ECTS studenta\n" +
                    "6 - oblicz sumę ects w danej grupie ";
            System.out.println(menu);

            String option = app.getOptionFromUser();
            System.out.println(option);
            app.executeCommand(option);
            app.closeConnection();
        } catch (SQLException eSQL) {
            System.out.println("Błąd przetwarzania SQL.");
        } catch (IOException eIO) {
            System.out.println("Błąd przetwarzania pliku.");
        }
    }

    private void executeCommand(String option) {
        switch (option) {
            case "1":
                try {
                    createGroup();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            case "2":
                try {
                    assignStudent();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            case "3":
                try {
                    evaluateStudent();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            case "4":
                try {
                    calculateStudentAverageMark();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            case "5":
                try {
                    calculateEctsSum();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            case "6":
                try {
                    calculateGroupEctsSum();
                } catch (SQLException eSQL) {
                    System.out.println("Błąd przetwarzania SQL.");
                }
                break;
            default:
                System.out.println("Niepoprawny wybór");
                break;
        }
    }

    private void calculateGroupEctsSum() throws SQLException {
        printStudentTable();
        System.out.println("Podaj ID studenta:");
        int studentID = Integer.parseInt(getOptionFromUser());

        printSubjectTypesTable();
        System.out.println("Podaj nazwę grupy:");
        String groupName = getOptionFromUser();
        String command = "{? = call CALCULATE_ECTS_SUM_GROUP(?, ?)}";

        CallableStatement cstmt = connection.prepareCall(command);
        cstmt.setInt(2, studentID);
        cstmt.setString(3, groupName);

        cstmt.registerOutParameter(1, Types.FLOAT);
        cstmt.executeUpdate();

        int result = cstmt.getInt(1);
        cstmt.close();
        System.out.println("Suma punktów ECTS wynosi: " + result);
    }


    private void calculateEctsSum() throws SQLException {
        printStudentTable();
        System.out.println("Podaj ID studenta:");
        int studentID = Integer.parseInt(getOptionFromUser());

        String command = "{? = call CALCULATE_ECTS_SUM(?)}";

        CallableStatement cstmt = connection.prepareCall(command);
        cstmt.setInt(2, studentID);
        cstmt.registerOutParameter(1, Types.FLOAT);
        cstmt.executeUpdate();


        int result = cstmt.getInt(1);
        cstmt.close();
        System.out.println("Suma punktów ECTS wynosi: " + result);
    }

    private void calculateStudentAverageMark() throws SQLException {
        printStudentTable();
        System.out.println("Podaj ID studenta:");
        int studentID = Integer.parseInt(getOptionFromUser());

        String command = "{? = call CALCULATE_AVERAGE_GRADE(?)}";
        CallableStatement cstmt = connection.prepareCall(command);
        cstmt.setInt(2, studentID);
        cstmt.registerOutParameter(1, Types.FLOAT);
        cstmt.executeUpdate();


        float result = cstmt.getFloat(1);
        cstmt.close();
        System.out.println("Średnia ocena wynosi: " + result);
    }

    private void evaluateStudent() throws SQLException {
        printSubjectTable();
        System.out.println("Podaj ID przedmiotu:");
        int subjectID = Integer.parseInt(getOptionFromUser());

        printStudentTable();
        System.out.println("Podaj ID studenta:");
        int studentID = Integer.parseInt(getOptionFromUser());

        printInstructorTable();
        System.out.println("Podaj ID prowadzącego:");
        int instructorID = Integer.parseInt(getOptionFromUser());

        System.out.println("Podaj ocenę:");
        float mark = Float.parseFloat(getOptionFromUser());

        String command = "{call ADD_MARK(?, ?, ?, ?)}";
        CallableStatement cstmt = connection.prepareCall(command);

        cstmt.setInt(1, instructorID);
        cstmt.setInt(2, studentID);
        cstmt.setInt(3, subjectID);
        cstmt.setFloat(4, mark);

        cstmt.execute();
        cstmt.close();
        System.out.println("Pomyślnie dodano ocenę.");
    }

    private void assignStudent() throws SQLException {
        printSubjectGroupTable();
        System.out.println("Podaj ID grupy:");
        int subjectGroupID = Integer.parseInt(getOptionFromUser());

        printStudentTable();
        System.out.println("Podaj ID studenta:");
        int studentID = Integer.parseInt(getOptionFromUser());

        String command = "{call REGIST_GROUP(?, ?)}";
        CallableStatement cstmt = connection.prepareCall(command);
        cstmt.setInt(1, subjectGroupID);
        cstmt.setInt(2, studentID);

        cstmt.execute();
        cstmt.close();
        System.out.println("Pomyślnie zarejestrowano studenta.");
    }

    private void createGroup() throws SQLException {
        printSubjectTable();
        System.out.println("Podaj ID przedmiotu:");
        int subjectID = Integer.parseInt(getOptionFromUser());

        printInstructorTable();
        System.out.println("Podaj ID prowadzącego:");
        int instructorID = Integer.parseInt(getOptionFromUser());

        System.out.println("Podaj pojemność grupy:");
        int capacity = Integer.parseInt(getOptionFromUser());

        String sql = "INSERT INTO  subject_group (capacity, instructor_id, subject_id) values(?,?,?)";
        PreparedStatement pstmt = connection.prepareStatement(sql);

        pstmt.setInt(1, capacity);
        pstmt.setInt(2, instructorID);
        pstmt.setInt(3, subjectID);

        pstmt.executeUpdate();
        pstmt.close();
        System.out.println("Pomyślnie utworzono grupę.");
    }

    private String getOptionFromUser() {
        Scanner sc = new Scanner(System.in);
        return sc.nextLine();
    }

    private void printSubjectTable() throws SQLException {
        Statement stat = connection.createStatement();
        ResultSet result = stat.executeQuery("SELECT * FROM subject");
        String rowTemplate = "%-2s|%-50s|%-4s|%-5s|";
        System.out.println(String.format(rowTemplate, "ID", "Nazwa przedmiotu", "ECTS", "Kod"));

        while (result.next()) {
            System.out.println(String.format(rowTemplate,
                    result.getString(1),
                    result.getString(2),
                    result.getString(3),
                    result.getString(4)));
        }
        result.close();
        stat.close();
    }

    private void printStudentTable() throws SQLException {
        Statement stat = connection.createStatement();
        ResultSet result = stat.executeQuery("SELECT * FROM student");
        String rowTemplate = "%-2s|%-30s|%-30s|%-6s|";
        System.out.println(String.format(rowTemplate, "ID", "Imię", "Nazwisko", "Indeks"));
        while (result.next()) {
            System.out.println(String.format(rowTemplate,
                    result.getString(1),
                    result.getString(2),
                    result.getString(3),
                    result.getString(6)));
        }
        result.close();
        stat.close();
    }

    private void printInstructorTable() throws SQLException {
        Statement stat = connection.createStatement();
        ResultSet result = stat.executeQuery("SELECT * FROM instructor");
        String rowTemplate = "%-2s|%-30s|%-30s|";
        System.out.println(String.format(rowTemplate, "ID", "Imię", "Nazwisko"));
        while (result.next()) {
            System.out.println(String.format(rowTemplate,
                    result.getString(1),
                    result.getString(2),
                    result.getString(3)));
        }
        result.close();
        stat.close();
    }

    private void printSubjectTypesTable() throws SQLException {
        Statement stat = connection.createStatement();
        ResultSet result = stat.executeQuery("SELECT * FROM subject_type");
        String rowTemplate = "%-2s|%-50s|";
        System.out.println(String.format(rowTemplate, "ID", "Nazwa"));
        while (result.next()) {
            System.out.println(String.format(rowTemplate,
                    result.getString(1),
                    result.getString(2)));
        }
        result.close();
        stat.close();
    }

    private void printSubjectGroupTable() throws SQLException {
        Statement stat = connection.createStatement();
        ResultSet result = stat.executeQuery("SELECT SG.SUBJECT_GROUP_ID, SG.CAPACITY, \n" +
                "    S.CODE, S.NAME,\n" +
                "    I.FIRST_NAME, I.LAST_NAME\n" +
                "FROM SUBJECT_GROUP SG\n" +
                "    JOIN INSTRUCTOR I ON SG.INSTRUCTOR_ID = I.INSTRUCTOR_ID\n" +
                "    JOIN SUBJECT S ON SG.SUBJECT_ID = S.SUBJECT_ID");

        String rowTemplate = "%-2s|%-10s|%-5s|%-50s|%-30s|%-30s|";
        System.out.println(String.format(rowTemplate, "ID", "Pojemność", "Kod", "Nazwa", "Imię prowadzącego", "Nazwisko prowadzącego"));
        while (result.next()) {
            System.out.println(String.format(rowTemplate, result.getString(1), result.getString(2),
                    result.getString(3), result.getString(4), result.getString(5), result.getString(6)));
        }
        result.close();
        stat.close();
    }

    private void setConnection() throws SQLException, IOException { // metoda nawiazuje polaczenie
        Properties prop = new Properties();
        FileInputStream in = new FileInputStream("connection.properties"); // w pliku znajduja sie parametry polaczenia
        prop.load(in); // zaczytanie danych z pliku properties
        in.close(); // zamkniecie pliku

        String host = prop.getProperty("jdbc.host");
        String username = prop.getProperty("jdbc.username");
        String password = prop.getProperty("jdbc.password");
        String port = prop.getProperty("jdbc.port");
        String serviceName = prop.getProperty("jdbc.service.name");

        String connectionString = String.format(
                "jdbc:oracle:thin:%s/%s@//%s:%s/%s",
                username, password, host, port, serviceName);

        System.out.println(connectionString);
        OracleDataSource ods; // nowe zrodlo danych (klasa z drivera  Oracle)
        ods = new OracleDataSource();

        ods.setURL(connectionString);
        connection = ods.getConnection(); // nawiazujemy polaczenie z BD

        DatabaseMetaData meta = connection.getMetaData();

        System.out.println("Połączenie do bazy danych nawiązane.");
        System.out.println("Baza danych:" + " " + meta.getDatabaseProductVersion());
    }

    private void closeConnection() throws SQLException { // zamkniecie polaczenia
        connection.close();
        System.out.println("Polaczenie z baza zamkniete poprawnie.");
    }
}
