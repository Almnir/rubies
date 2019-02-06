using System;

class ArrayTest
{
    public static void Main()
    {
        // матрица
        int[,] testArray = new int [5000,5000];
        // создаем рандом
        Random random = new Random();
        int randomNum;
        
        // посчитаем простое заполнение матрицы рандомом
        DateTime sTime = DateTime.Now;
        // заполняем матрицу рандомом
        for (int i=0; i < 5000; i++)
            for (int j=0; j < 5000; j++)
                testArray[i, j] = random.Next(100,1000);
        // смотрим сколько
        TimeSpan eTime = DateTime.Now - sTime;
        Console.WriteLine("Time Elapsed: {0} ms",eTime);
        
        // посчитаем самое затратное
        sTime = DateTime.Now;
        // караем матрицу адски медленным делением на рандом с двумя кастами
        for (int i=0; i < 5000; i++)
            for (int j=0; j < 5000; j++)
            {
                randomNum = random.Next(2,10);
                testArray[i, j] = (int)(Math.Round(testArray[i, j]/(double)randomNum));
            }    
        eTime = DateTime.Now - sTime;
        Console.WriteLine("Time Elapsed: {0} ms",eTime);    
    }
}
