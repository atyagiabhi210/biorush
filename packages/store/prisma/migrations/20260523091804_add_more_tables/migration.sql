-- CreateEnum
CREATE TYPE "FunctionalityFlag" AS ENUM ('OPTIMAL', 'SUBOPTIMAL', 'CONCERNING');

-- CreateEnum
CREATE TYPE "BioMarkerFlag" AS ENUM ('LOW', 'NORMAL', 'HIGH', 'CRITICALLY_LOW', 'CRITICALLY_HIGH');

-- CreateEnum
CREATE TYPE "ReportStatus" AS ENUM ('PENDING', 'REVIEW', 'CONFIRMED', 'FAILED');

-- CreateTable
CREATE TABLE "LabReports" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "pdf_url" TEXT NOT NULL,
    "lab_name" TEXT NOT NULL,
    "report_date" TIMESTAMP(3) NOT NULL,
    "status" "ReportStatus" NOT NULL,
    "ai_summary" TEXT,
    "bioscore" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LabReports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BioMarkers" (
    "id" TEXT NOT NULL,
    "report_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "ref_range_low" DOUBLE PRECISION,
    "ref_range_high" DOUBLE PRECISION,
    "flag" "BioMarkerFlag",
    "functionality_flag" "FunctionalityFlag",
    "panel" TEXT,
    "confidence" DOUBLE PRECISION,
    "manually_edited" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BioMarkers_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "LabReports" ADD CONSTRAINT "LabReports_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BioMarkers" ADD CONSTRAINT "BioMarkers_report_id_fkey" FOREIGN KEY ("report_id") REFERENCES "LabReports"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BioMarkers" ADD CONSTRAINT "BioMarkers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
