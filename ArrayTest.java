import java.util.Random;

class ArrayTest
{
	public static void main(String[] args)
	{
		int testArray[][] = new int[5000][5000];
		Random randomGenerator = new Random();
		int randNext;

		long t1 = System.nanoTime();

		for (int i=0; i<5000; ++i)
			for (int j=0; j<5000; ++j)
				testArray[i][j] = 100 + randomGenerator.nextInt() % 1000;

		long t2 = System.nanoTime();
    	System.out.println("1st time: " + ((t2 - t1) * 1e-6) + " milliseconds");

    	t1 = System.nanoTime();
		for (int i=0; i<5000; ++i)
			for (int j=0; j<5000; ++j)
			{
				randNext = 2 + randomGenerator.nextInt() % 10;
				testArray[i][j] = Math.round(testArray[i][j]/(float)randNext);
			}
		t2 = System.nanoTime();
    	System.out.println("2nd time: " + ((t2 - t1) * 1e-6) + " milliseconds");
	}
}