const { GoogleGenerativeAI } = require("@google/generative-ai");

async function checkModels() {
  const apiKey = "AIzaSyAW61zZr_HZIm9M437Zzdd0kiIyOHWzboM";
  const genAI = new GoogleGenerativeAI(apiKey);

  console.log("Checking API Key: " + apiKey.substring(0, 10) + "...");

  try {
    const models = ["gemini-1.5-flash", "gemini-1.5-pro", "gemini-pro"];

    for (const modelName of models) {
      console.log(`\nTesting model: ${modelName}...`);
      try {
        const model = genAI.getGenerativeModel({ model: modelName });
        const result = await model.generateContent("Hi");
        const response = await result.response;
        console.log(`Success with ${modelName}: ${response.text().substring(0, 20)}...`);
      } catch (e) {
        console.error(`Status for ${modelName}: ${e.message}`);
      }
    }
  } catch (error) {
    console.error("Critical Error:", error);
  }
}

checkModels();
