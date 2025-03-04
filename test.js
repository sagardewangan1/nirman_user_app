const fs = require('fs');
const path = require('path');

// Function to read Dart files from the directory and subdirectories
function readDartFiles(dirPath) {
  let filesToProcess = [];
  
  // Read the directory and process files and subdirectories
  const files = fs.readdirSync(dirPath);
  
  files.forEach(file => {
    const fullPath = path.join(dirPath, file);
    const stat = fs.statSync(fullPath);
    
    if (stat.isDirectory()) {
      // Recurse into subdirectories
      filesToProcess = filesToProcess.concat(readDartFiles(fullPath));
    } else if (file.endsWith('.dart')) {
      // Collect Dart files
      filesToProcess.push(fullPath);
    }
  });
  
  return filesToProcess;
}

// Function to extract string literals from a Dart file
function extractTextFromDartFile(filePath) {
  const fileContent = fs.readFileSync(filePath, 'utf8');
  
  // Regular expression to capture any string inside double quotes (ignores non-string content)
  const regex = /"([^"]*)"/g;  // Matches content between double quotes
  let matches;
  const extractedText = {};
  
  // Find all string literals and add them to the extractedText object
  while ((matches = regex.exec(fileContent)) !== null) {
    const text = matches[1].trim();  // Remove leading/trailing spaces from the text
    
    if (text !== "") {
      // Convert text to snake_case (lowercase, spaces to underscores) for keys
      const key = text.toLowerCase().replace(/\s+/g, '_');  // Replace spaces with underscores and lowercase
      extractedText[key] = text;  // Store the key-value pair without modifying the value
    }
  }
  
  return extractedText;
}

// Main function to process all Dart files and extract the string literals
function extractTextFromProject(projectDir) {
  const dartFiles = readDartFiles(projectDir);
  let allExtractedText = {};

  dartFiles.forEach(file => {
    const text = extractTextFromDartFile(file);
    allExtractedText = { ...allExtractedText, ...text };  // Merge all extracted text
  });

  return allExtractedText;
}

// Save extracted text into a JSON file for Flutter localization
function saveToJsonFile(data, outputFile) {
  const jsonContent = JSON.stringify(data, null, 2);
  fs.writeFileSync(outputFile, jsonContent, 'utf8');
}

// Example usage
const projectDir = path.join(__dirname, 'lib');  // Replace 'lib' with your actual directory
const outputFile = 'en.json';  // Flutter's typical localization file

const extractedText = extractTextFromProject(projectDir);

// Log extracted text for debugging
console.log(extractedText);

if (Object.keys(extractedText).length > 0) {
  saveToJsonFile(extractedText, outputFile);
  console.log(`Localization JSON file has been saved to ${outputFile}`);
} else {
  console.log("No matching text found in Dart files.");
}