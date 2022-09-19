import * as fs from 'fs';

const configUrl = process.env.CONFIG;

export const config = JSON.parse(
  fs.readFileSync(`${configUrl}/config.json`).toString(),
);
