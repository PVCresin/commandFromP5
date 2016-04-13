import java.io.*;

void setup() {
  command("cmd", "/c", "dir");
  command("java", "-version");
}

void command(String... params) {
  println("\n========================================");
  try {
    ProcessBuilder pb = new ProcessBuilder(params);
    pb.directory(new File(sketchPath()));

    Process process = pb.start();
    process.waitFor();

    printInputStream(process.getInputStream());
    printInputStream(process.getErrorStream());
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}

void printInputStream(InputStream is) throws IOException {
  BufferedReader br = new BufferedReader(new InputStreamReader(is));
  try {    
    while (true) {
      String tempStr = br.readLine();
      if (tempStr == null) break;
      else println(tempStr);
    }
  }
  finally {
    br.close();
  }
}