import { Pool } from "pg";
import { PrismaClient } from "./generated/prisma/client";
import "dotenv/config";
import { PrismaPg } from "@prisma/adapter-pg";
if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not set");
}

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export const prisma = new PrismaClient({
  adapter: new PrismaPg(pool),
});

export * from "./generated/prisma/client";
