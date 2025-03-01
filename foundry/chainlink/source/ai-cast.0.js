if (!secrets.openaiKey) throw Error('Need OPENAI_KEY environment variable');

const data = {
  'model': 'gpt-4o-mini', 'messages': [
    {
      'role': 'system',
      'content': 'Always answer with one word: YES or NO'
    },
    {
      'role': 'user',
      'content': args[0]
    }
  ]
};

const openAIRequest = Functions.makeHttpRequest({
  url: 'https://api.openai.com/v1/chat/completions',
  method: 'POST',
  headers: {
    'Content-Type': `application/json`,
    'Authorization': `Bearer ${secrets.openaiKey}`,
   },
  data: data
})

const [openAiResponse] = await Promise.all([openAIRequest]);
// console.log('raw response', JSON.stringify(openAiResponse,null,2));

const result = openAiResponse.data.choices[0].message.content;
console.log('result:', result);

return Functions.encodeString(result);
